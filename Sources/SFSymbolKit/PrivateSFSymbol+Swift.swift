//
//  PrivateSFSymbol+Swift.swift
//  SFSymbolKit
//

import Swift

extension Swift.String {
    /// The identifier of the private SF symbol.
    ///
    /// Use this to get the raw identifier of the symbol from ``PrivateSFSymbol``.
    ///
    /// ```swift
    /// Image(_internalSystemName: ._sfSymbol(.activity_award)) // type-safe, version awared.
    /// ```
    ///
    /// > Warning:
    /// >
    /// > The `Image` API is public but the symbols are private, so you use them at your own risks.
    public static func _sfSymbol(_ symbol: PrivateSFSymbol) -> String {
        symbol.rawValue
    }
}
