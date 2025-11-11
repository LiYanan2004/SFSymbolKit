//
//  SFSymbolDescriptor.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxBuilder

internal struct SFSymbolDescriptor: Hashable, Sendable {
    var identifier: String
    var availability: String
    
    var availablePlatforms: [String]
}

extension SFSymbolDescriptor {
    var declarationSyntax: some DeclSyntaxProtocol {
        get throws {
            let propertyIdentifier = identifier.replacingOccurrences(of: ".", with: "_")
            let validIdentifier = propertyIdentifier.isValidSwiftIdentifier(for: .variableName) ? propertyIdentifier : "`\(propertyIdentifier)`"
            
            let attributeList = AttributeListSyntax {
                AttributeSyntax(
                    "@available(\(raw: availablePlatforms.joined(separator: ", ")), *)"
                ).with(\.trailingTrivia, .newline + .tab)
            }
            
            return try VariableDeclSyntax("""
            static public let \(raw: validIdentifier) = SFSymbol(rawValue: \"\(raw: self.identifier)\")
            """)
            .with(\.attributes, attributeList)
            .with(\.leadingTrivia, .newline + .tab)
            .with(\.trailingTrivia, .newline)
        }
    }
}
