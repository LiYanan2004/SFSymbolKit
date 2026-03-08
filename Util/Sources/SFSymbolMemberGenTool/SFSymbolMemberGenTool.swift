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
    
    func run() throws {
        try printStep("Generating", printDone: true) {
            try SFSymbolMembersGenerator(directoryURL: directoryURL)
                .generate()
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
