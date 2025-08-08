//
//  WaterweedApp.swift
//  Waterweed
//
//

import AppKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        let window = MSWindow(contentRect: .init(x: 0, y: 0, width: 640, height: 480),
                              styleMask: [.titled, .closable, .resizable, .miniaturizable],
                              backing: .buffered, defer: false)
        window.contentView = NSView()
        window.title = "Window"
        window.isReleasedWhenClosed = false
        window.center()
        window.makeKeyAndOrderFront(nil)
        window.makeMain()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }

    static func main() {
        let delegate = AppDelegate()
        withExtendedLifetime(delegate) {
            let app = NSApplication.shared
            app.delegate = delegate
            app.run()
        }
    }
}

