//
//  main.swift
//  SFSymbolKit
//
//  Created by LiYanan2004 on 2025/11/9.
//

import SwiftUI
import SFSymbolKit

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: .sfSymbol(.globe))
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
