//
//  MSWindow.swift
//  Waterweed
//
//

import AppKit

class MSWindow: NSWindow {

    var iconView: NSImageView?

    var titleBarView: NSView? {
        self.standardWindowButton(.closeButton)?.superview
    }

    static let windowFrameWidth = 6.0
    static let titleBarHeight = 26.0

    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)
        updateTitleBarConstraints()
        buildContentView()

        let center = NotificationCenter.default
        center.addObserver(forName: NSWindow.didEndLiveResizeNotification,
                           object: self, queue: nil, using: windowDidEndLiveResize(_:))
    }

    func updateTitleBarConstraints() {
        guard let closeButton = self.standardWindowButton(.closeButton) else { return }
        guard let titlebar = closeButton.superview else { return }

        let zoomButton = self.standardWindowButton(.zoomButton)
        let minimizeButton = self.standardWindowButton(.miniaturizeButton)

        // Do not attempt to modify title bar height via constraint. Use frame instead.
        titlebar.setFrameSize(.init(width: titlebar.frame.width, height: MSWindow.titleBarHeight))

        // Only update constraints if none has been set

        if closeButton.constraints.count == 0 {
            closeButton.translatesAutoresizingMaskIntoConstraints = false
            closeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            closeButton.trailingAnchor.constraint(equalTo: titlebar.trailingAnchor, constant: -MSWindow.windowFrameWidth).isActive = true
        }

        if zoomButton?.constraints.count == 0 {
            zoomButton!.translatesAutoresizingMaskIntoConstraints = false
            zoomButton!.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            zoomButton!.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -6).isActive = true
        }

        if minimizeButton?.constraints.count == 0 {
            minimizeButton!.translatesAutoresizingMaskIntoConstraints = false
            minimizeButton!.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            minimizeButton!.trailingAnchor.constraint(equalTo: zoomButton!.leadingAnchor, constant: -6).isActive = true
        }

        if iconView == nil {
            let icon = NSApp.applicationIconImage
            let iconView = NSImageView(image: icon!)

            iconView.translatesAutoresizingMaskIntoConstraints = false
            iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
            iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor).isActive = true
            titlebar.addSubview(iconView)

            iconView.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            iconView.leadingAnchor.constraint(equalTo: titlebar.leadingAnchor, constant: MSWindow.windowFrameWidth + 1.0).isActive = true

            self.iconView = iconView
        }

        // Initial call to set up our title bar
        updateTitleText(withTitleBar: titlebar)
    }

    func updateTitleText(withTitleBar titlebar: NSView) {
        guard let text = titlebar.subviews.first(where: { $0 is NSTextField }) as? NSTextField else { return }

        // Entering and exiting fullscreen might reset our constraint
        if text.constraints.count == 0 {
            text.translatesAutoresizingMaskIntoConstraints = false
            text.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
            text.leadingAnchor.constraint(equalTo: iconView!.trailingAnchor, constant: 4).isActive = true
        }

        // Reset text styles
        text.alignment = .natural
        text.font = .systemFont(ofSize: NSFont.systemFontSize, weight: .regular)
    }

    func buildContentView() {
        self.isOpaque = false
        self.backgroundColor = .clear.withAlphaComponent(0.005)
        self.titlebarAppearsTransparent = true

        let view = MSVisualEffectView()
        view.material = .fullScreenUI
        view.blendingMode = .behindWindow
        view.tintColor = .init(red: 0.42, green: 0.45, blue: 0.72, alpha: 0.988)
        view.state = .active
        self.contentView = view

        let glass = MSGlassView()
        glass.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glass)
    }

    func windowDidEndLiveResize(_: Notification) {
        updateTitleBarConstraints()
    }
}
