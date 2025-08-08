#!/usr/bin/swift
import AppKit

let window = NSWindow()
window.setContentSize(.init(width: 640, height: 480))
window.styleMask = [.titled, .closable, .resizable, .miniaturizable]
window.contentView = NSView()
window.title = "Window"
window.center()

let closeButton = window.standardWindowButton(.closeButton)!
let zoomButton = window.standardWindowButton(.zoomButton)!
let minimizeButton = window.standardWindowButton(.miniaturizeButton)!
let titlebar = closeButton.superview!

closeButton.translatesAutoresizingMaskIntoConstraints = false
closeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
closeButton.trailingAnchor.constraint(equalTo: titlebar.trailingAnchor, constant: -7).isActive = true

zoomButton.translatesAutoresizingMaskIntoConstraints = false
zoomButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
zoomButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -6).isActive = true

minimizeButton.translatesAutoresizingMaskIntoConstraints = false
minimizeButton.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
minimizeButton.trailingAnchor.constraint(equalTo: zoomButton.leadingAnchor, constant: -6).isActive = true

let titleText = titlebar.subviews.first { $0 is NSTextField }!
titleText.translatesAutoresizingMaskIntoConstraints = false
titleText.centerYAnchor.constraint(equalTo: titlebar.centerYAnchor).isActive = true
titleText.leadingAnchor.constraint(equalTo: titlebar.leadingAnchor, constant: 7).isActive = true

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        window.makeKeyAndOrderFront(nil)
        window.makeMain()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

let delegate = AppDelegate()
NSApp.delegate = delegate
NSApp.activate()
NSApp.setActivationPolicy(.regular)
NSApp.run()
