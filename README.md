# Rokt SDK+ for iOS (RoktSDKPlus)

**Rokt SDK+** is an umbrella that pulls the [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk), the [mParticle Rokt kit](https://github.com/mparticle-integrations/mp-apple-integration-rokt) (**mParticle-Rokt** [v9.1.0+](https://github.com/mparticle-integrations/mp-apple-integration-rokt/releases) with `rokt-contracts-apple` 2.x), and [Rokt Payment Extension](https://github.com/ROKT/rokt-payment-extension-ios).

Swift module and CocoaPods pod name: **`RoktSDKPlus`**.

## Upstream READMEs

For full installation options, troubleshooting, and advanced topics, use the upstream guides (this repo only summarizes what you need alongside **RoktSDKPlus**):

- **[mParticle Apple SDK — README](https://github.com/mParticle/mparticle-apple-sdk/blob/main/README.md)** — core SDK via SwiftPM/CocoaPods, kits overview, and initialization.
- **[mParticle Rokt kit — README](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/README.md)** — kit-specific SwiftPM/CocoaPods lines, Shoppable Ads, and event APIs.

Official documentation: [mParticle iOS SDK](https://docs.mparticle.com/developers/sdk/ios/), [Rokt + mParticle](https://docs.rokt.com/developers/integration-guides/rokt-ads/customer-data-platforms/mparticle/).

## Versioning

SwiftPM and CocoaPods target **mParticle Apple SDK 9.1+**, **mParticle-Rokt 9.1+**, and **RoktPaymentExtension 2+** so every dependency agrees on **`RoktContracts` 2.x** and the package manager picks one compatible version.

## Swift Package Manager

In `Package.swift` or Xcode → *Package Dependencies*:

```swift
.package(
    url: "https://github.com/ROKT/sdk-plus-ios.git",
    .upToNextMajor(from: "1.0.0")
)
```

Add the **`RoktSDKPlus`** product to your app target, then import `RoktSDKPlus` and the upstream modules you need (for example `mParticle_Apple_SDK`, `mParticle_Rokt_Swift`, `RoktPaymentExtension`).

If you were integrating **without** this umbrella, the core SDK would be added from `https://github.com/mParticle/mparticle-apple-sdk` (product **`mParticle-Apple-SDK`**) and the kit from `https://github.com/mparticle-integrations/mp-apple-integration-rokt` (product **`mParticle-Rokt`**), per the [mParticle README](https://github.com/mParticle/mparticle-apple-sdk/blob/main/README.md) and [Rokt kit README](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/README.md).

## CocoaPods

In your `Podfile`:

```ruby
pod 'RoktSDKPlus', '~> 1.0'
```

Match deployment target and Swift version expectations to the upstream podspecs (this podspec uses **iOS 15.6** and **Swift 5.9**). If you add the pieces yourself instead of **RoktSDKPlus**, use at least **`~> 9.1`** for both `mParticle-Apple-SDK` and `mParticle-Rokt` (upstream examples may show `~> 9` / `~> 9.0`; see the [mParticle README](https://github.com/mParticle/mparticle-apple-sdk/blob/main/README.md) and [Rokt kit README](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/README.md)).

## mParticle core (essential)

The [mParticle Apple SDK](https://github.com/mParticle/mparticle-apple-sdk) is the hub for forwarding data to enabled integrations; kits (such as Rokt) are separate targets your app links against—**RoktSDKPlus** already links the core and Rokt kit for you.

Initialize the SDK from `application(_:didFinishLaunchingWithOptions:)` (do **not** defer startup with `dispatch_async`). A minimal Swift start:

```swift
import mParticle_Apple_SDK

func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
    let options = MParticleOptions(key: "<<<App Key Here>>>", secret: "<<<App Secret Here>>>")
    // Supply identifyRequest / onIdentifyComplete as needed; see https://docs.mparticle.com/developers/sdk/ios/identity/
    MParticle.sharedInstance().start(with: options)
    return true
}
```

See the full [mParticle Apple SDK README](https://github.com/mParticle/mparticle-apple-sdk/blob/main/README.md) for Objective‑C, tvOS, crash reporter, and the supported kits table.

## mParticle Rokt kit (essential)

After install, rebuild and run with mParticle log level **Debug** or higher; you should see `Included kits: { Rokt }` in the Xcode console ([Rokt kit README](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/README.md)).

**Placements** (Swift):

```swift
MParticle.sharedInstance().rokt.selectPlacements(
    "checkout",
    attributes: ["email": "user@example.com"],
    embeddedViews: ["Location1": embeddedView],
    config: nil
) { event in
    if event is RoktEvent.PlacementReady {
        // Placement is ready
    }
}
```

**Shoppable Ads** use a registered payment extension (for example Stripe) and `selectShoppableAds`; see the [Rokt kit README](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/README.md) for `registerPaymentExtension` / `selectShoppableAds` snippets and [MIGRATING.md](https://github.com/mparticle-integrations/mp-apple-integration-rokt/blob/main/MIGRATING.md) for event types.

## License

See [LICENSE](LICENSE). Upstream SDKs remain under their respective licenses.
