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

        guard let material = self.layer?.sublayers?.first as? CALayer else { return }
        for layer in material.sublayers! {
            switch layer.name {
            case "backdrop":
                layer.backgroundColor = self.tintColor.copy(alpha: self.tintColor.alpha * 0.08)
                updateLayerFilter(layer)
            case "fill":
                layer.backgroundColor = self.tintColor.copy(alpha: self.tintColor.alpha * 0.43)
                layer.compositingFilter = "multiplyBlendMode"
            case "tone", "Chameleon":
                layer.backgroundColor = .clear
                layer.opacity = 0
                layer.isHidden = true
            default: continue
            }
        }
    }

    func updateLayerFilter(_ layer: CALayer) {
        for filterObject in layer.filters ?? [] {
            guard let filter = filterObject as? NSObject else { continue } // CAFilter
            print("filter:", type(of: filter).className(), filter.value(forKey: "name") ?? "(?)", type(of: filter.value(forKey: "name")!))
            guard let name = filter.value(forKey: "name") as? NSString else { continue }

            switch name {
            case "gaussianBlur":
                filter.setValue(7.0, forKey: "inputRadius")
            case "colorSaturate":
                print("amount:", filter.value(forKey: "inputAmount") ?? "(?)")
                filter.setValue(0.5, forKey: "inputAmount")
            default: continue
            }

            // Prints the filter name out for easier debugging
            print("filter", name)
        }
    }
}
