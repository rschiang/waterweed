//
//  CGGradient+Extension.swift
//  Waterweed
//
//

import CoreGraphics

extension CGGradient {
    static func fromGrayPoints(values: [CGFloat], locations: [CGFloat]) -> CGGradient? {
        .init(colorsSpace: nil, colors: values.map { CGColor(gray: 1.0, alpha: $0) } as CFArray, locations: locations)
    }
}
