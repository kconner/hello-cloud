// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "app",
    dependencies: [
        .package(name: "Swifter", url: "https://github.com/httpswift/swifter.git", .upToNextMajor(from: "1.4.7")),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "app",
            dependencies: [
                .product(name: "Swifter", package: "Swifter"),
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "appTests",
            dependencies: ["app"]
        ),
    ]
)
