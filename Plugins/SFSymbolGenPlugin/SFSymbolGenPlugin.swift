import Foundation
import PackagePlugin

@main
struct SFSymbolGenPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        guard let swiftTarget = target as? SwiftSourceModuleTarget else {
            Diagnostics.warning("SymbolGenPlugin can only run for Swift source targets.")
            return []
        }
        
        let outputFileURL = context.pluginWorkDirectoryURL
            .appending(path: "sf-symbol.generate.swift")
        let arguments: [String] = [
            "--output", outputFileURL.path,
        ]

        let generator = try context.tool(named: "SFSymbolGenTool")
        
        return [
            .buildCommand(
                displayName: "Generating SF Symbols for \(swiftTarget.name)",
                executable: generator.url,
                arguments: arguments,
                environment: [:],
                inputFiles: [],
                outputFiles: [outputFileURL]
            )
        ]
    }
}
