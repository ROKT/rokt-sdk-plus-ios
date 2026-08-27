# Contributing

`ROKT/rokt-sdk-plus-ios` is the SwiftPM and CocoaPods release mirror for Rokt SDK+. The development source lives at [`Kits/rokt-sdk-plus/rokt-sdk-plus-ios`](https://github.com/mParticle/mparticle-apple-sdk/tree/main/Kits/rokt-sdk-plus/rokt-sdk-plus-ios) in the mParticle Apple SDK monorepo.

## Proposing a change

1. Open the change against the [mParticle Apple SDK monorepo](https://github.com/mParticle/mparticle-apple-sdk).
2. Follow that repository's [contribution guide](https://github.com/mParticle/mparticle-apple-sdk/blob/main/CONTRIBUTING.md).
3. Keep changes to the Rokt SDK+ subtree unless the change intentionally updates shared mParticle code.

Accepted upstream changes are mirrored here by the release process. Pull requests opened directly against this repository may be closed and redirected upstream so the development source and release mirror do not diverge.

## Mirror validation

Mirror updates run one lightweight check that:

- parses the Swift package manifest;
- checks the CocoaPods podspec syntax; and
- confirms the package, podspec, and public module versions remain aligned.

Product development and broad platform builds belong in the upstream monorepo, where the surrounding SDK and integration-kit test suites are available.
