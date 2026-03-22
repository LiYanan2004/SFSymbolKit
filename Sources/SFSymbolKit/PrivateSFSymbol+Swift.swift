//
//  PrivateSFSymbol+Swift.swift
//  SFSymbolKit
//

import Swift

extension Swift.String {
    /// The identifier of the private SF symbol.
    ///
    /// Use this to get the raw identifier of the symbol from ``PrivateSFSymbol``
    ///
    /// For example:
    ///
    /// ```swift
    /// Image(_systemName: ._sfSymbol(.activity_award)) // type-safe, version awared.
    /// ```
    public static func _sfSymbol(_ symbol: PrivateSFSymbol) -> String {
        symbol.rawValue
    }
}
