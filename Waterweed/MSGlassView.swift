//
//  MSGlassLayer.swift
//  Waterweed
//
//

import AppKit

class MSGlassView: NSView {

    static let shineGradient: CGGradient = .init(colorsSpace: nil,
                                          colors: [
                                            CGColor(gray: 1.0, alpha: 0.25),
                                            CGColor(gray: 1.0, alpha: 0.0),
                                          ] as CFArray,
                                          locations: nil)!

    static let reflectionGradient: CGGradient = .fromGrayPoints(
        values: [
            0.0, 0.0156, 0.0392, 0.051, 0.051, 0.047, 0.0352, 0.0196, 0.0,
            0.0, 0.0118, 0.0392, 0.047, 0.0392, 0.008, 0.0,
            0.0, 0.008, 0.0118, 0.0, 0.0, 0.043, 0.051, 0.0314,
            0.0, 0.008, 0.0118, 0.0314, 0.0392, 0.047, 0.051, 0.0156, 0.0
        ],
        locations: [
            0.0, 0.025, 0.06, 0.095, 0.125, 0.155, 0.205, 0.245, 0.26,
            0.465, 0.475, 0.49, 0.555, 0.57, 0.58, 0.59,
            0.66, 0.665, 0.68, 0.705, 0.735, 0.75, 0.755, 0.805,
            0.825, 0.87, 0.89, 0.915, 0.935, 0.94, 0.975, 0.9875, 1.0,
        ])!

    var isShineVisible: Bool = false {
        didSet { self.needsDisplay = true }
    }

    override var isFlipped: Bool { true }

    override init(frame: NSRect) {
        super.init(frame: frame)
        self.layerContentsRedrawPolicy = .onSetNeedsDisplay
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func resize(withOldSuperviewSize oldSize: NSSize) {
        self.setNeedsDisplay(self.bounds)
    }

    override func draw(_: NSRect) {
        let ctx = NSGraphicsContext.current!.cgContext

        for i in 0...Int(ceil(self.bounds.width / 800)) {
            let x = 1400.0 * Double(i)
            ctx.drawLinearGradient(MSGlassView.reflectionGradient,
                                   start: .init(x: x, y: 600.0),
                                   end: .init(x: x + 800.0, y: 0.0),
                                   options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])

        }

        if isShineVisible {
            ctx.drawRadialGradient(MSGlassView.shineGradient,
                                   startCenter: .init(x: 0.0, y: 0.0),
                                   startRadius: 0.0,
                                   endCenter: .init(x: 228.0, y: 228.0),
                                   endRadius: 228.0,
                                   options: .drawsAfterEndLocation)
        }
    }

    override func updateLayer() {
        super.updateLayer()
        self.layer?.compositingFilter = "overlayBlendMode"
    }

    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        guard let superview = self.superview else { return }
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: superview.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superview.heightAnchor).isActive = true
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        guard let window = self.window else { return }
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(windowDidBecomeKey(_:)), name: NSWindow.didBecomeKeyNotification, object: window)
        center.addObserver(self, selector: #selector(windowDidResignKey(_:)), name: NSWindow.didResignKeyNotification, object: window)
    }

    @objc func windowDidBecomeKey(_: Notification) {
        self.layer?.opacity = 0.9
    }

    @objc func windowDidResignKey(_: Notification) {
        self.layer?.opacity = 0.75
    }
}
