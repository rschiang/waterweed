//
//  MSVisualEffectView.swift
//  Waterweed
//
//

import AppKit

class MSVisualEffectView: NSVisualEffectView {

    let glassLayer = MSGlassView()

    var tintColor: CGColor = .clear {
        didSet { self.needsDisplay = true }
    }

    override func updateLayer() {
        super.updateLayer()
        guard let backingLayer = self.layer else { return }
        guard let material = backingLayer.sublayers?.first as? CALayer else { return }
        let isWindowActive = self.window?.isKeyWindow ?? false

        // Group our actions in batches, disable fade-in animations
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        defer { CATransaction.commit() }

        for layer in material.sublayers! {
            switch layer.name {
            case "backdrop":
                for filterObject in layer.filters ?? [] {
                    guard let filter = filterObject as? NSObject else { continue } // CAFilter
                    guard let name = filter.value(forKey: "name") as? NSString else { continue }
                    switch name {
                    case "gaussianBlur":
                        filter.setValue(5.0, forKey: "inputRadius")
                    case "colorSaturate":
                        filter.setValue(0.51, forKey: "inputAmount")
                    default: continue
                    }
                }

            case "fill":
                layer.backgroundColor = .clear

            case "tone":
                layer.backgroundColor = self.tintColor.copy(alpha: self.tintColor.alpha * (isWindowActive ? 0.43 : 0.032))
                layer.compositingFilter = "multiplyBlendMode"

            default: continue
            }
        }
    }

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        guard let window = self.window else { return }
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(windowDidBecomeKey(_:)), name: NSWindow.didBecomeKeyNotification, object: window)
        center.addObserver(self, selector: #selector(windowDidResignKey(_:)), name: NSWindow.didResignKeyNotification, object: window)
    }

    @objc func windowDidBecomeKey(_: Notification) {
        self.needsDisplay = true
    }

    @objc func windowDidResignKey(_: Notification) {
        self.needsDisplay = true
    }
}
