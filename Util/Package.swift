// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SFSymbolKitUtil",
    platforms: [
        .macOS(.v15),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.6.2"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "602.0.0-latest"),
        .package(url: "https://github.com/OpenSwiftUIProject/DarwinPrivateFrameworks.git", exact: "0.0.5"),
    ],
    targets: [
        .target(
            name: "SFSymbolMemberGen",
            dependencies: [
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxBuilder", package: "swift-syntax"),
                .product(name: "SFSymbols", package: "DarwinPrivateFrameworks"),
            ]
        ),
        .executableTarget(
            name: "SFSymbolMemberGenTool",
            dependencies: [
                "SFSymbolMemberGen",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
    ]
)
