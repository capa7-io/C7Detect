// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "C7Detect",
    platforms: [
        .iOS(.v13),
        .macOS(.v13)
    ],
    products: [
        .library(name: "C7Detect", targets: ["C7Detect"]),
        .library(name: "C7DetectDevelopment", targets: ["C7DetectDevelopment"])
    ],
    targets: [
        .binaryTarget(name: "C7Detect", path: "Frameworks/C7Detect.zip"),
        .binaryTarget(name: "C7DetectDevelopment", path: "Frameworks/C7DetectDevelopment.zip")
    ]
)
