// swift-tools-version: 5.9
import PackageDescription

/// **Rokt SDK+** (`RoktSDKPlus`) — bundles [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk),
/// [mParticle-Rokt 9.1+](https://github.com/mparticle-integrations/mp-apple-integration-rokt) (`RoktContracts` 2.x),
/// and [Rokt Payment Extension](https://github.com/ROKT/rokt-payment-extension-ios) 2.x.
let package = Package(
    name: "RoktSDKPlus",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "RoktSDKPlus",
            targets: ["RoktSDKPlus"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/mParticle/mparticle-apple-sdk.git",
            .upToNextMajor(from: "9.1.0")
        ),
        .package(
            url: "https://github.com/mparticle-integrations/mp-apple-integration-rokt.git",
            .upToNextMajor(from: "9.1.0")
        ),
        .package(
            url: "https://github.com/ROKT/rokt-payment-extension-ios.git",
            .upToNextMajor(from: "2.0.0")
        ),
    ],
    targets: [
        .target(
            name: "RoktSDKPlus",
            dependencies: [
                .product(name: "mParticle-Apple-SDK", package: "mparticle-apple-sdk"),
                .product(name: "mParticle-Rokt", package: "mp-apple-integration-rokt"),
                .product(name: "RoktPaymentExtension", package: "rokt-payment-extension-ios"),
            ],
            path: "Sources/RoktSDKPlus"
        ),
    ]
)
