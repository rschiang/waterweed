//
//  NSAppearanceCustomization+Extension.swift
//  Waterweed
//
//

import AppKit

extension NSAppearanceCustomization {
    var isDarkMode: Bool {
        self.effectiveAppearance.bestMatch(from: [.aqua, .darkAqua]) == .darkAqua
    }
}
