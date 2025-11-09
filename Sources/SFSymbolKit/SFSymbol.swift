//
//  SFSymbol.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

/// A set of type-safe, availability-awared SF Symbol representations.
///
/// It serves as a namespace of apple's official system symbols (aka. SF Symbols).
///
/// Because all symbols are pre-defined, you can easily find them using code completion, avoiding typos and improving accuracy. The compiler also helps you manage symbol availabilities.
///
/// All dots (`.`) are replaced with underscore (`_`), for example:
/// - `SFSymbol.character_bubble_fill`
///   - Equivalent SF Symbol identifier is `character.bubble.fill`
///
/// Here is an example:
///
/// ```swift
/// struct ContentView: View {
///    var body: some View {
///        VStack {
///            Image(systemName: .sfSymbol(.globe)) // type-safe symbol
///                .imageScale(.large)
///                .foregroundStyle(.tint)
///            Text("Hello, world!")
///        }
///        .padding()
///    }
/// }
/// ```
public struct SFSymbol: RawRepresentable, Hashable, Sendable {
    /// The raw identifier of an SF Symbol.
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
