# SFSymbolKit

Type-safe, availability-aware SF Symbols.

The goal of this package is to:
- check symbol availabilities
- avoid accidental symbol name typos

All at compile-time.

## Requirements

- iOS 13.0+
- macOS 10.15+
- tvOS 13.0+
- watchOS 6.0+
- visionOS 1.0+

## Getting Started

Add **SFSymbolKit** to your Swift Package Manager manifest.

```swift
.package(url: "https://github.com/LiYanan2004/SFSymbolKit.git", branch: "main"),
```

Include `SFSymbolKit` in any targets that need it.

```swift
.target(
    name: "MyTarget",
    dependencies: [
        .product(name: "SFSymbolKit", package: "SFSymbolKit"),
    ]
),
```

### Pick an SF Symbol

You still uses familiar APIs -- for example: `Image(systemName:)` -- but instead of manually typing the symbol name, you can use `.sfSymbol(_:)`.

```swift
import SwiftUI
import SFSymbolKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: .sfSymbol(.globe))
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, Symbols!")
        }
        .padding()
    }
}
```

This unlocks the same safety for UIKit/AppKit apps.

```swift
let identifier = String.sfSymbol(.sparkles)
let image = UIImage(systemName: identifier)
imageView.preferredSymbolConfiguration = .init(scale: .large)
imageView.image = image
```

### Availability-Aware

Every generated `SFSymbol` member carries the same `@available` attributes Apple assigns to the original glyph, so you get compiler guidance instead of runtime surprises.

Now, when you usage a symbol, the compiler will help you check the availability -- say your app needs to macOS 15 -- if you use new symbol that does not support on certain OS, you will see an error.

```swift
Image(systemName: .sfSymbol(.suitcase_rolling_and_suitcase)) // ❌ 'suitcase_rolling_and_suitcase' is only available in OS 26.0 or newer
```

You can fix that by selecting another symbol for unsupported platforms.

```swift
if #available(iOS 26.0, macOS 26.0, *) {
    Label("Onboarding", systemImage: .sfSymbol(.suitcase_rolling_and_suitcase))
} else {
    Label("Onboarding", systemImage: .sfSymbol(.airplane))
}
```

![](/Resources/availability-check.png)

## Update `SFSymbolKit`

All static members of `SFSymbol` is generated using `SFSymbolMemberGenTool`

Basically, it retrieves all available symbols from Apple's `SFSymbolFramework`

> [!TIP]
> located at `/System/Library/PrivateFrameworks/SFSymbols.framework`
>
> Don't worry, this package does NOT touch any private APIs.

You can update the `SFSymbol` of this package by running `./update_symbols.sh` if I don't get a chance to update this package!
