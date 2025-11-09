//
//  SFSymbolGenTool.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation
import ArgumentParser
import SFSymbolGen

@main
struct SFSymbolGenTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Generate SFSymbol type with all available symbols that statically mapped to raw names, offering code completion during app developement."
    )

    @Option(
        name: .shortAndLong,
        help: "Path to the Swift file that should receive the generated symbols.",
        transform: { URL(fileURLWithPath: ($0 as NSString).expandingTildeInPath) }
    )
    var output: URL
    
    @Flag(name: .short)
    var force: Bool = false

    func run() throws {
        guard needsGenerate else { return }
        try SFSymbolSourceFileGenerator(outputURL: output)
            .generate()
    }
    
    private var needsGenerate: Bool {
        !FileManager.default.fileExists(atPath: output.path) || force
    }
}
