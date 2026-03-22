#!/bin/bash

swift run --package-path Util SFSymbolMemberGenTool --output ./Sources/SFSymbolKit/SF\ Symbols/ --private-output ./Sources/SFSymbolKit/Private\ SF\ Symbols/
