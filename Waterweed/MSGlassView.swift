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
                                                CGColor(gray: 1.0, alpha: 0.085),
                                                CGColor(gray: 1.0, alpha: 0.0785),
                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0585),
                                                CGColor(gray: 1.0, alpha: 0.0785),
                                                CGColor(gray: 1.0, alpha: 0.085),
                                                CGColor(gray: 1.0, alpha: 0.0785),

                                                CGColor(gray: 1.0, alpha: 0.0118),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0040),
                                                CGColor(gray: 1.0, alpha: 0.0156),
                                                CGColor(gray: 1.0, alpha: 0.0196),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                                CGColor(gray: 1.0, alpha: 0.0),
                                               ] as CFArray,
                                               locations: [
                                                0.01, 0.02, 0.065, 0.08, 0.09, 0.095, 0.105, 0.12, 0.13, 0.135,
                                                0.1425, 0.145, 0.16, 0.1825, 0.19, 0.23
                                               ])!

    override var isFlipped: Bool {
        true
    }

    override func draw(_: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext
        ctx.drawLinearGradient(reflectionGradient,
                               start: .init(x: 0.0, y: 000.0),
                               end: .init(x: 800.0, y: -600.0),
                               options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
        ctx.drawRadialGradient(shineGradient,
                               startCenter: .init(x: 0.0, y: 0.0),
                               startRadius: 0.0,
                               endCenter: .init(x: 228.0, y: 228.0),
                               endRadius: 228.0,
                               options: .drawsAfterEndLocation)
    }
}
