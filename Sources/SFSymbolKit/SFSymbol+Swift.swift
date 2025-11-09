//
//  SFSymbol+Swift.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Swift

extension Swift.String {
    /// The identifier of the SF symbol.
    ///
    /// Use this to get the raw identifier of the symbol from ``SFSymbol``
    ///
    /// For example:
    ///
    /// ```swift
    /// Image(systemName: .sfSymbol(.globe)) // type-safe, version awared.
    /// ```
    public static func sfSymbol(_ symbol: SFSymbol) -> String {
        symbol.rawValue
    }
}
