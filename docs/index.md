# C7Detect

[![Swift](https://img.shields.io/badge/Swift-5.7_5.8_5.9_5.10-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.7_5.8_5.9_5.10-Orange?style=flat-square)
[![Platforms](https://img.shields.io/badge/Platforms-macOS_iOS-Green?style=flat-square)](https://img.shields.io/badge/Platforms-macOS_iOS-Green?style=flat-square)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/C7Detect.svg?style=flat-square)](https://img.shields.io/cocoapods/v/C7Detect.svg)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)](https://img.shields.io/badge/Swift_Package_Manager-compatible-orange?style=flat-square)

C7Detect is a library for detecting security risks in iOS / macOS libraries and applications.

- [Threats detected](#threats-detected)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [About this library](#about-this-library)

## Threats detected

- [x] Running on Simulator.
- [x] Running from Xcode.
- [x] Debugger attached/present.
- [x] Malicious processes.
- [x] Malicious files.
- [x] Jailbreak.
- [x] Unprotected Sandbox.

## Requirements

- iOS 13.0+
- macOS 13.0+

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding C7Detect as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/capa7-io/C7Detect.git", .upToNextMajor(from: "1.0.0"))
]
```

Normally you'll want to depend on the `C7Detect` target:

```swift
.product(name: "C7Detect", package: "C7Detect")
```

But if you want to avoid detections in simulators (do not do this in production versions), you can depend on the `C7DetectDevelopment` target:

```swift
.product(name: "C7DetectDevelopment", package: "C7Detect")
```

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate C7Detect into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'C7Detect'
```

The pod 'C7DetectDevelopment' is also available for development purposes.

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate C7Detect into your project manually. Download this repository and copy the C7Detect.xcframework available at the Frameworks folder inside your project.

## Usage

1. Implement a class named **C7DHandler** with the following content.

```swift
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
```

2. Query **threadsDetected** before performing any sensitive operation in your library or application, in order to detect threats. If **C7DHandler.threadsDetected** is not empty then there is a risk that a malicious actor is trying to modify and/or intercept information in your code.

### Sample application

There is a sample application that uses C7Detect (which triggers events in devices _and_ simulators) at SampleApp/C7DetectSampleApp.xcodeproj.

![Threats detected on Simulator](https://capa7-io.github.io/C7Detect/images/simulator_screenshot_threats.png "Threats detected on Simulator")

## About this library

### What does this library doesn't do

- It does not provide obfuscation for libraries or applications.
- It does not protect the C7Handler class that receives the detected threats. This protection should be provided by a a tool that secures your library or application.

### Skipping checks on simulators

This repository contains a C7Detect version for development (C7DetectDevelopment) which does not perform threats detection on Simulators. **Use it wisely**.
