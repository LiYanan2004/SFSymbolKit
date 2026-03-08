//
//  SFSymbols.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation
import SFSymbols

internal enum SFSymbols_Private {
    static internal let allSymbolDescriptors: [SFSymbolDescriptor] = {
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
              let availabilityMap = plist["year_to_release"] as? [String : [String : String]] else {
            return []
        }

        let availabilities = availabilityMap.mapValues({ availabilities in
            availabilities.map({
                "\($0.key) \($0.value)" // e.g. iOS 26.0
            }).sorted(by: <)
        })

        var symbolCategories: [String : [String]]?
        let symbolCategoriesPlistPath = coreGlyphsBundle
            .path(forResource: "symbol_categories", ofType: "plist")
        if let symbolCategoriesPlistPath {
            symbolCategories = NSDictionary(
                contentsOfFile: symbolCategoriesPlistPath
            ) as? [String : [String]]
            symbolCategories = symbolCategories?.mapValues { categories in
                categories.filter({ $0 != "whatsnew" }) // Already organized by year so no need to include this category.
            }
        }

        var symbolSearch: [String : [String]]?
        let symbolSearchPlistPath = coreGlyphsBundle
            .path(forResource: "symbol_search", ofType: "plist")
        if let symbolSearchPlistPath {
            symbolSearch = NSDictionary(
                contentsOfFile: symbolSearchPlistPath
            ) as? [String : [String]]
        }

        let scalars = privateScalarByName

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
                availablePlatforms: availabilities,
                categories: symbolCategories?[symbolName],
                searchKeywords: symbolSearch?[symbolName],
                privateScalar: scalars[symbolName]
            )
        }
    }()

    static let privateScalarByName: [String: UnicodeScalar] = {
        var result = [String: UnicodeScalar]()
        let store = SymbolMetadataStore.system
        let mirror = Mirror(reflecting: store)
        for child in mirror.children {
            if let rows = child.value as? [String: SystemSymbolCSVRow] {
                for (name, row) in rows {
                    result[name] = row.privateScalar
                }
            } else if let rows = child.value as? [SystemSymbolCSVRow] {
                for row in rows {
                    result[row.name] = row.privateScalar
                }
            }
        }
        return result
    }()

    static let sfSymbolsFrameworkURL = URL(
        fileURLWithPath: "/System/Library/PrivateFrameworks/SFSymbols.framework/"
    )
}
