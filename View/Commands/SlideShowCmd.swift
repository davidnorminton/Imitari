//
//  SlideShowCmd.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct SlideShowCmd: View {
    
    @Binding var showSlideShow: Bool
    @Binding var slideShowInterval: Int
    
    var body: some View {
        Button("Play slide show") {
            showSlideShow = true
        }
        
        Button("Slide show Settings") {
            // create a new NSPanel
            showSlideShow = false
            let window = NSPanel(
                contentRect: NSRect(x: 0, y: 0, width: 450, height: 200),
                styleMask: [.fullSizeContentView, .closable, .resizable, .titled],
                backing: .buffered, defer: false
            )
            let settingsView = AppSettings(slideShowInterval: $slideShowInterval)
            window.center()
            window.contentView = NSHostingView(rootView: settingsView)
            window.title = "Slide show settings"
            window.makeKeyAndOrderFront(nil)
        }
        Divider()
    }
}
