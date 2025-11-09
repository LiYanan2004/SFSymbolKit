// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SFSymbolKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "SFSymbolKit",
            targets: ["SFSymbolKit"]
        ),
        .executable(
            name: "SFSymbolKitClient",
            targets: ["SFSymbolKitClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.2"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"),
    ],
    targets: [
        .target(
            name: "SFSymbolMemberGen",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
            ]
        ),
        .executableTarget(
            name: "SFSymbolMemberGenTool",
            dependencies: [
                "SFSymbolMemberGen",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "SFSymbolKit"
        ),
        .executableTarget(
            name: "SFSymbolKitClient",
            dependencies: ["SFSymbolKit"]
        ),
    ]
)
