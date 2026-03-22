//
//  PrivateSFSymbol.swift
//  SFSymbolKit
//

import Foundation

/// A set of type-safe, availability-awared private SF Symbol representations.
///
/// It serves as a namespace of apple's private system symbols.
///
/// Because all symbols are pre-defined, you can easily find them using code completion, avoiding typos and improving accuracy. The compiler also helps you manage symbol availabilities.
///
/// All dots (`.`) are replaced with underscore (`_`), for example:
/// - `PrivateSFSymbol.activity_award`
///   - Equivalent SF Symbol identifier is `activity.award`
///
/// Here is an example:
///
/// ```swift
/// struct ContentView: View {
///    var body: some View {
///        VStack {
///            Image(_systemName: ._sfSymbol(.activity_award)) // type-safe symbol
///                .imageScale(.large)
///                .foregroundStyle(.tint)
///            Text("Hello, world!")
///        }
///        .padding()
///    }
/// }
/// ```
public struct PrivateSFSymbol: RawRepresentable, Hashable, Sendable {
    /// The raw identifier of a private SF Symbol.
    public var rawValue: String

    @available(*, deprecated, message: "Use predefined Private SF Symbols instead. For example: `PrivateSFSymbol.activity_award`.")
    public init(rawValue: String) {
        self.init(identifier: rawValue)
    }

    internal init(identifier: String) {
        self.rawValue = identifier
    }
}
