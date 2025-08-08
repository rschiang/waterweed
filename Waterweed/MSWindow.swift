//
//  MSWindow.swift
//  Waterweed
//
//

import AppKit

class MSWindow: NSWindow {

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        updateTitleBarConstraints()
    }

    func updateTitleBarConstraints() {
        guard let closeButton = self.standardWindowButton(.closeButton) else { return }
        guard let titlebar = closeButton.superview else { return }

        let zoomButton = self.standardWindowButton(.zoomButton)!
        let minimizeButton = self.standardWindowButton(.miniaturizeButton)!

        let titleBarMargin = 7.0
        let titleBarSpacing = 6.0

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: titlebar.trailingAnchor, constant: -titleBarMargin).isActive = true

        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        zoomButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        zoomButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -titleBarSpacing).isActive = true

        minimizeButton.translatesAutoresizingMaskIntoConstraints = false
        minimizeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        minimizeButton.trailingAnchor.constraint(equalTo: zoomButton.leadingAnchor, constant: -titleBarSpacing).isActive = true

        let titleText = titlebar.subviews.first { $0 is NSTextField }!
        titleText.translatesAutoresizingMaskIntoConstraints = false
        titleText.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: titlebar.leadingAnchor, constant: titleBarMargin).isActive = true
    }
}
