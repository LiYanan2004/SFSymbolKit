//
//  SFSymbols.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

internal enum SFSymbols_Private {    
    static internal let allSymbols: [SFSymbolDescriptor] = {
        // find CoreGlyphs.bundle
        let coreGlyphsBundlePath = Bundle(url: sfSymbolsFrameworkURL)?
            .path(forResource: "CoreGlyphs", ofType: "bundle")
        guard let coreGlyphsBundlePath,
              let coreGlyphsBundle = Bundle(path: coreGlyphsBundlePath)
        else { return [] }
        
        // fetch ordered symbols
        let symbolList = coreGlyphsBundle.path(forResource: "symbol_order", ofType: "plist")
        guard let symbolList,
              let symbols = NSArray(contentsOfFile: symbolList) as? [String] else {
            return []
        }
        
        // fetch symbol availabilities
        let availabilityList = coreGlyphsBundle.path(forResource: "name_availability", ofType: "plist")
        guard let availabilityList,
              let plist = NSDictionary(contentsOfFile: availabilityList),
              let symbolAvailabilityDict = plist["symbols"] as? [String : String],
              let availabilities = plist["year_to_release"] as? [String : [String : String]] else {
            return []
        }
        
        return symbols.compactMap { symbolName -> SFSymbolDescriptor? in
            guard let availability = symbolAvailabilityDict[symbolName] else {
                return nil
            }
            guard let availabilities = availabilities[availability] else {
                return nil
            }
            return SFSymbolDescriptor(
                identifier: symbolName,
                availability: availability,
                availablePlatforms: availabilities.map({
                    "\($0.key) \($0.value)" // e.g. iOS 26.0
                })
            )
        }
    }()
    
    static let sfSymbolsFrameworkURL = URL(
        fileURLWithPath: "/System/Library/PrivateFrameworks/SFSymbols.framework/"
    )
}
