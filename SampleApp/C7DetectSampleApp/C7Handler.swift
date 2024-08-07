import Foundation

@objc(C7DHandler)
final class C7DHandler: NSObject {
    private static var semaphore = DispatchSemaphore(value: 1)
    private static var _threatsDetected = [NSNotification]()

    // Returns the detected threats.
    public static var threatsDetected: [NSNotification] {
        return _threatsDetected
    }

    @objc
    static func on(notification: NSNotification) {
        // Wait for the semaphore
        C7DHandler.semaphore.wait()
        // Store the notification (could be map to any other domain model)
        C7DHandler._threatsDetected.append(notification)
        // Release for the semaphore
        C7DHandler.semaphore.signal()
    }
}
