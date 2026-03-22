//
//  SFSymbolGenTool.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation
import ArgumentParser
import SFSymbolMemberGen

@main
struct SFSymbolMemberGenTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generate SFSymbol properties that statically mapped to raw symbol identifiers."
    )

    @Option(
        name: [.customShort("o"), .customLong("output")],
        help: "Path to the directory to save a bunch of SF Symbol declarations.",
        transform: {
            URL(fileURLWithPath: ($0 as NSString).expandingTildeInPath)
        }
    )
    var directoryURL: URL

    @Option(
        name: [.customShort("p"), .customLong("private-output")],
        help: "Path to the directory to save a bunch of Private SF Symbol declarations.",
        transform: {
            URL(fileURLWithPath: ($0 as NSString).expandingTildeInPath)
        }
    )
    var privateDirectoryURL: URL?

    func run() throws {
        let generator = SFSymbolMembersGenerator(
            directoryURL: directoryURL,
            privateDirectoryURL: privateDirectoryURL
        )

        try printStep("Generating SF Symbols", printDone: true) {
            try generator.generate()
        }

        if privateDirectoryURL != nil {
            try printStep("Generating Private SF Symbols", printDone: true) {
                try generator.generatePrivate()
            }
        }
    }

    private func printStep(
        _ label: some CustomStringConvertible,
        printDone: Bool = false,
        _ action: @escaping () throws -> Void
    ) rethrows {
        print("\(label.description)...")
        try action()
        if printDone {
            print("[\(label)] Done.")
        }
    }
}
