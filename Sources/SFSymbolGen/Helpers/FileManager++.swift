//
//  FileManager++.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

extension FileManager {
    func createDirectoryIfNecessary(for url: URL) throws {
        guard !fileExists(atPath: url.path) else { return }
        try createDirectory(at: url, withIntermediateDirectories: true)
    }
}
