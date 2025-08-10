//
//  MSGlassLayer.swift
//  Waterweed
//
//

import AppKit

class MSGlassView: NSView {

    let shineGradient: CGGradient = .init(colorsSpace: nil,
                                          colors: [
                                            CGColor(gray: 1.0, alpha: 0.375),
                                            CGColor(gray: 1.0, alpha: 0.0),
                                          ] as CFArray,
                                          locations: nil)!

    let reflectionGradient: CGGradient = .init(colorsSpace: nil,
                                               colors: [
                                                CGColor(gray: 1.0, alpha: 0.051),
                                                CGColor(gray: 1.0, alpha: 0.0156),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0156),
                                                CGColor(gray: 1.0, alpha: 0.0392),
                                                CGColor(gray: 1.0, alpha: 0.051),
                                                CGColor(gray: 1.0, alpha: 0.051),
                                                CGColor(gray: 1.0, alpha: 0.047),
                                                CGColor(gray: 1.0, alpha: 0.0352),
                                                CGColor(gray: 1.0, alpha: 0.0196),
                                                CGColor(gray: 1.0, alpha: 0.0),

                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0392),
                                                CGColor(gray: 1.0, alpha: 0.047),
                                                CGColor(gray: 1.0, alpha: 0.0392),
                                                CGColor(gray: 1.0, alpha: 0.008),
                                                CGColor(gray: 1.0, alpha: 0.0),

                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.008),
                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0),

                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.043),
                                                CGColor(gray: 1.0, alpha: 0.051),
                                                CGColor(gray: 1.0, alpha: 0.0314),

                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.008),
                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0314),
                                                CGColor(gray: 1.0, alpha: 0.0392),
                                                CGColor(gray: 1.0, alpha: 0.047),
                                                CGColor(gray: 1.0, alpha: 0.051),
                                               ] as CFArray,
                                               locations: [
                                                0.0, 0.0125, 0.025, 0.05, 0.085, 0.12, 0.18, 0.23, 0.27, 0.285,
                                                0.49, 0.5, 0.515, 0.58, 0.595, 0.605, 0.615,
                                                0.685, 0.69, 0.705, 0.73,
                                                0.76, 0.775, 0.78, 0.83,
                                                0.85, 0.895, 0.915, 0.94, 0.96, 0.965, 1.0
                                               ])!

    override var isFlipped: Bool {
        true
    }

    override func draw(_: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext
        ctx.drawLinearGradient(reflectionGradient,
                               start: .init(x: 0.0, y: 600.0),
                               end: .init(x: 800.0, y: 0.0),
                               options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        ctx.drawRadialGradient(shineGradient,
                               startCenter: .init(x: 0.0, y: 0.0),
                               startRadius: 0.0,
                               endCenter: .init(x: 228.0, y: 228.0),
                               endRadius: 228.0,
                               options: .drawsAfterEndLocation)
    }
}
