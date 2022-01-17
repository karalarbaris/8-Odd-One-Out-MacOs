//
//  WindowController.swift
//  8-Odd-One-Out-MacOs
//
//  Created by Baris Karalar on 17.01.2022.
//

import Cocoa

class WindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        window?.styleMask = [window!.styleMask, .fullSizeContentView]
        window?.titlebarAppearsTransparent = true
        window?.titleVisibility = .hidden
        window?.isMovableByWindowBackground = true
    }

}
