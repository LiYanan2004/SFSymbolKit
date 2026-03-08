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
    var categories: [String]?
    var searchKeywords: [String]?
    var privateScalar: UnicodeScalar?
    
    private var hasMetadata: Bool {
        if let categories, !categories.isEmpty {
            return true
        }
        
        if let searchKeywords, !searchKeywords.isEmpty {
            return true
        }
        
        return false
    }
}

extension SFSymbolDescriptor {
    var declarationSyntax: some DeclSyntaxProtocol {
        get throws {
            let propertyIdentifier = identifier.replacingOccurrences(of: ".", with: "_")
            let validIdentifier = propertyIdentifier.isValidSwiftIdentifier(for: .variableName) ? propertyIdentifier : "`\(propertyIdentifier)`"
            
            return try VariableDeclSyntax("""
            static public let \(raw: validIdentifier) = SFSymbol(identifier: \"\(raw: self.identifier)\")
            """)
            .with(\.leadingTrivia, documentationBlockTrivia)
            .with(\.trailingTrivia, .newline)
        }
    }
    
    private var documentationBlockTrivia: Trivia {
        var documentationTrivia = Trivia.tab
        let docTitle: String
        if let privateScalar {
            docTitle = "/// \(privateScalar) `\(identifier)`"
        } else {
            docTitle = "/// `\(identifier)`"
        }
        appendDocumentationLine(
            content: docTitle,
            to: &documentationTrivia
        )
        if let categories, !categories.isEmpty {
            appendDocumentationLine(
                content: "///",
                to: &documentationTrivia
            )
            appendDocumentationLine(
                content: "/// - categories:",
                to: &documentationTrivia
            )
            for category in categories {
                appendDocumentationLine(
                    content: "///   - `\(category)`",
                    to: &documentationTrivia
                )
            }
        }
        
        if let searchKeywords, !searchKeywords.isEmpty {
            appendDocumentationLine(
                content: "///",
                to: &documentationTrivia
            )
            appendDocumentationLine(
                content: "/// - search keywords:",
                to: &documentationTrivia
            )
            for keword in searchKeywords {
                appendDocumentationLine(
                    content: "///   - `\(keword)`",
                    to: &documentationTrivia
                )
            }
        }
        
        return .newline + documentationTrivia
    }
    
    private func appendDocumentationLine(
        content: String,
        to trivia: inout Trivia
    ) {
        trivia = trivia.appending(
            TriviaPiece.docLineComment(content)
        )
        trivia = trivia.appending(.newline)
        trivia = trivia.appending(.tab)
    }
}
