// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SFSymbolKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SFSymbolKit",
            targets: ["SFSymbolKit"]
        ),
    ],
    targets: [
        .target(
            name: "SFSymbolKit"
        ),
    ]
)
