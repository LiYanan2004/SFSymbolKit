//
//  SFSymbols.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

internal enum SFSymbols_Private {
    static let allSymbols: [String] = {
        // find CoreGlyphs.bundle
        let coreGlyphsBundlePath = Bundle(url: sfSymbolsFrameworkURL)?
            .path(forResource: "CoreGlyphs", ofType: "bundle")
        guard let coreGlyphsBundlePath,
              let coreGlyphsBundle = Bundle(path: coreGlyphsBundlePath)
        else { return [] }
        
        // fetch all symbol names
        let resourcePath = coreGlyphsBundle.path(forResource: "name_availability", ofType: "plist")
        guard let resourcePath,
              let plist = NSDictionary(contentsOfFile: resourcePath),
              let symbols = plist["symbols"] as? [String : String] else {
            return []
        }
        
        return Array(symbols.keys)
    }()
    
    static let sfSymbolsFrameworkURL = URL(
        fileURLWithPath: "/System/Library/PrivateFrameworks/SFSymbols.framework/"
    )
}
