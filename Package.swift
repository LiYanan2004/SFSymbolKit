// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

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
        .plugin(
            name: "SFSymbolGenPlugin",
            targets: ["SFSymbolGenPlugin"]
        ),
        .executable(
            name: "SFSymbolGenClient",
            targets: ["SFSymbolGenClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.2"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"),
    ],
    targets: [
        .target(
            name: "SFSymbolGen",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
            ]
        ),
        .executableTarget(
            name: "SFSymbolGenTool",
            dependencies: [
                "SFSymbolGen",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .plugin(
            name: "SFSymbolGenPlugin",
            capability: .buildTool,
            dependencies: ["SFSymbolGenTool"]
        ),
        .executableTarget(
            name: "SFSymbolGenClient",
            plugins: [
                .plugin(name: "SFSymbolGenPlugin")
            ]
        ),
    ]
)
