// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PantristCapacitorPluginMlKitTextRecognition",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CapacitorPluginMlKitTextRecognitionPlugin",
            targets: ["CapacitorPluginMlKitTextRecognitionPlugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/ionic-team/capacitor-swift-pm.git", branch: "6.0.0")
    ],
    targets: [
        .target(
            name: "CapacitorPluginMlKitTextRecognitionPlugin",
            dependencies: [
                .product(name: "Capacitor", package: "capacitor-swift-pm"),
                .product(name: "Cordova", package: "capacitor-swift-pm")
            ],
            path: "ios/Sources/CapacitorPluginMlKitTextRecognitionPlugin"),
        .testTarget(
            name: "CapacitorPluginMlKitTextRecognitionPluginTests",
            dependencies: ["CapacitorPluginMlKitTextRecognitionPlugin"],
            path: "ios/Tests/CapacitorPluginMlKitTextRecognitionPluginTests")
    ]
)