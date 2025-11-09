//
//  SFSymbols.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

internal enum SFSymbols_Private {
    internal struct SFSymbolDescriptor: Hashable {
        var identifier: String
        var availabilities: [String]
    }
    
    static internal let allSymbols: [SFSymbolDescriptor] = {
        // find CoreGlyphs.bundle
        let coreGlyphsBundlePath = Bundle(url: sfSymbolsFrameworkURL)?
            .path(forResource: "CoreGlyphs", ofType: "bundle")
        guard let coreGlyphsBundlePath,
              let coreGlyphsBundle = Bundle(path: coreGlyphsBundlePath)
        else { return [] }
        
        // fetch all symbol descriptors
        let resourcePath = coreGlyphsBundle.path(forResource: "name_availability", ofType: "plist")
        guard let resourcePath,
              let plist = NSDictionary(contentsOfFile: resourcePath),
              let symbols = plist["symbols"] as? [String : String],
              let availabilities = plist["year_to_release"] as? [String : [String : String]] else {
            return []
        }
        
        return symbols.compactMap { name, availability in
            guard let availabilities = availabilities[availability] else {
                return nil
            }
            return SFSymbolDescriptor(
                identifier: name,
                availabilities: availabilities.map({
                    "\($0.key) \($0.value)" // e.g. iOS 26.0
                })
            )
        }
    }()
    
    static let sfSymbolsFrameworkURL = URL(
        fileURLWithPath: "/System/Library/PrivateFrameworks/SFSymbols.framework/"
    )
}
