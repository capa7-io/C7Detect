import SwiftUI
import Combine

struct ContentView: View {
    // Use @StateObject to create an instance of ThreatMonitor
    @StateObject private var threatMonitor = ThreatMonitor()

    var body: some View {
        VStack {
            Image(systemName: "shield\(threatMonitor.threats.isEmpty ? ".fill" : "")")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Threats detected: \(threatMonitor.threats.count)")
            Text(threatMonitor.threats.map { threat in
                "- \(threat.name.rawValue)"
            }.joined(separator: "\n"))
        }
        .padding()
    }
}

// ObservableObject to manage monitoring
class ThreatMonitor: ObservableObject {
    // Published to notify SwiftUI views of changes
    @Published var threats: [NSNotification] = []
    
    // Private properties
    private var cancellables = Set<AnyCancellable>()
    private var lastThreatsState: [NSNotification] = []

    // Subject to publish changes
    private let threatsSubject = PassthroughSubject<[NSNotification], Never>()

    init() {
        startMonitoring()
    }

    private func startMonitoring() {
        // Set up a timer publisher that fires every second
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                // Check if the list has changed
                if C7DHandler.threatsDetected != self.lastThreatsState {
                    // Publish the changes
                    self.threatsSubject.send(C7DHandler.threatsDetected)
                    // Update the last known state
                    self.lastThreatsState = C7DHandler.threatsDetected
                    // Update the published property
                    self.threats = C7DHandler.threatsDetected
                }
            }
            .store(in: &cancellables)
    }
}
#Preview {
    ContentView()
}
