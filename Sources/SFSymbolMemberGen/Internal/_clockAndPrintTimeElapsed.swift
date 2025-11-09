//
//  _clockAndPrintTimeElapsed.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import Foundation

@inlinable
package func _clockAndPrintTimeElapsed<T>(
    label: String? = nil,
    _ operation: () throws -> T
) rethrows -> T {
    let startTime = CFAbsoluteTimeGetCurrent()
    
    let result: T = try operation()
    
    let endTime = CFAbsoluteTimeGetCurrent()
    if #available(macOS 12.0, *) {
        let formattedTimeElapsed = (endTime - startTime)
            .formatted(.number.precision(.fractionLength(...10)))
        print("\(label ?? "Total Time Elapsed"):", formattedTimeElapsed, "second(s)")
    }
    
    return result
}
