//
//  MSWindow.swift
//  Waterweed
//
//

import AppKit

class MSWindow: NSWindow {

    var iconView: NSImageView?

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        updateTitleBarConstraints()
        buildContentView()
    }

    func updateTitleBarConstraints() {
        guard let closeButton = self.standardWindowButton(.closeButton) else { return }
        guard let titlebar = closeButton.superview else { return }

        let zoomButton = self.standardWindowButton(.zoomButton)!
        let minimizeButton = self.standardWindowButton(.miniaturizeButton)!

        let titleBarMargin = 7.0
        let titleBarSpacing = 6.0

        // Only update constraints if none has been set
        if closeButton.constraints.count == 0 {
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            closeButton.trailingAnchor.constraint(equalTo: titlebar.trailingAnchor, constant: -titleBarMargin).isActive = true
        }

        if zoomButton.constraints.count == 0 {
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        zoomButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        zoomButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -titleBarSpacing).isActive = true
        }

        if minimizeButton.constraints.count == 0 {
            minimizeButton.translatesAutoresizingMaskIntoConstraints = false
            minimizeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            minimizeButton.trailingAnchor.constraint(equalTo: zoomButton.leadingAnchor, constant: -titleBarSpacing).isActive = true
        }

        if iconView == nil {
            let icon = NSImage(systemSymbolName: "macwindow", accessibilityDescription: "")?.withSymbolConfiguration(.preferringMulticolor()) ?? NSApp.applicationIconImage
            let iconView = NSImageView(image: icon!)

            iconView.translatesAutoresizingMaskIntoConstraints = false
            iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
            titlebar.addSubview(iconView)
            iconView.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            iconView.leadingAnchor.constraint(equalTo: titlebar.leadingAnchor, constant: titleBarMargin).isActive = true

            self.iconView = iconView
        }

        let titleText = titlebar.subviews.first { $0 is NSTextField }! as! NSTextField
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: iconView!.trailingAnchor, constant: titleBarSpacing).isActive = true
        titleText.alignment = .natural
        titleText.textColor = .labelColor
        //titleText.font = .systemFont(ofSize: NSFont.systemFontSize, weight: .medium)

        let titleShadow = NSShadow()
        titleShadow.shadowColor = .white.withAlphaComponent(0.6)
        titleShadow.shadowBlurRadius = 10.0
        titleShadow.shadowOffset = .zero
        titleText.wantsLayer = true
        titleText.shadow = titleShadow
    }

    func buildContentView() {
        self.isOpaque = false
        self.backgroundColor = .clear.withAlphaComponent(0.005)
        self.titlebarAppearsTransparent = true

        let view = MSVisualEffectView()
        view.material = .fullScreenUI
        view.blendingMode = .behindWindow
        view.state = .active
        self.contentView = view

        let content = NSView()
        let layer = content.makeBackingLayer()
        layer.backgroundColor = NSColor.windowBackgroundColor.cgColor
        layer.borderColor = NSColor.black.withAlphaComponent(0.28).cgColor
        layer.borderWidth = 1.0
        content.layer = layer
        view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -8).isActive = true
        content.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
        content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        content.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
}

class MSVisualEffectView: NSVisualEffectView {
    override func updateLayer() {
        super.updateLayer()
        guard let material = self.layer?.sublayers?.first as? CALayer else { return }
        for layer in material.sublayers! {
            switch layer.name {
            case "backdrop":
                updateLayerFilter(layer)
            case "fill", "tone":
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
                filter.setValue(5.0, forKey: "inputRadius")
            default: continue
            }
        }
    }
}
