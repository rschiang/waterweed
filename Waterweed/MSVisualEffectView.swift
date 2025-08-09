//
//  MSVisualEffectView.swift
//  Waterweed
//
//

import AppKit

class MSVisualEffectView: NSVisualEffectView {

    var tintColor: CGColor = .clear {
        didSet { self.needsDisplay = true }
    }

    override func updateLayer() {
        super.updateLayer()
        guard let material = self.layer?.sublayers?.first as? CALayer else { return }
        for layer in material.sublayers! {
            switch layer.name {
            case "backdrop":
                updateLayerFilter(layer)
            case "fill":
                layer.backgroundColor = self.tintColor
            case "tone":
                layer.backgroundColor = .clear
            default: continue
            }
        }
    }

    func updateLayerFilter(_ layer: CALayer) {
        for filterObject in layer.filters ?? [] {
            guard let filter = filterObject as? NSObject else { continue } // CAFilter
            guard let name = filter.value(forKey: "name") as? String else { continue }
            switch name {
            case "gaussianBlur":
                filter.setValue(7.0, forKey: "inputRadius")
            default: continue
            }
        }
    }
}
