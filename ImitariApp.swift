//
//  ImitariApp.swift
//  Imitari
//
//  Created by david norminton on 18/11/2023.
//

import SwiftUI
import PhotosUI
import Foundation

@main
struct ImitariApp: App {
   
    // EnviromentObject states
    @StateObject var currentAppState = CurrentAppState()
    @StateObject var slideShowState = SlideShowState()
    
    @State private var importing = false
    @State private var windowCount = 1

    var body: some Scene {

        WindowGroup {
            GeometryReader { proxy in
                ContentView()
                .environmentObject(currentAppState)
                .environmentObject(slideShowState)
                .onOpenURL(perform: { url in
                    Logger.shared.log("open url.")
                    Logger.shared.log(url.absoluteString)
                    Logger.shared.log(url.relativePath)
                    Logger.shared.log(url.path())

                    currentAppState.setCurrentByChoice(path: url.path())
                })
            }
        }
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem) {
                Button("Open image or directory") {
                    importing = true
                    currentAppState.isVertFlipped = false
                    currentAppState.isHorzFlipped = false
                }
                .fileImporter(
                    isPresented: $importing,
                    allowedContentTypes: [.png, .jpeg, .gif, .directory]
                ) { result in
                    switch result {
                    case .success(let file):
                        let filePath: String = file.path()

                        currentAppState.setCurrentState(path: filePath)
                        
                        file.stopAccessingSecurityScopedResource()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }

            }
            CommandMenu("Tools") {
                // Next, previous
                Navigate().environmentObject(currentAppState)
                // slideshow controls
                SlideShowCmd().environmentObject(slideShowState)
                // Image zoom
                ZoomCmdsGroup().environmentObject(currentAppState)
                // Aspect ratio
                ScaleContent().environmentObject(currentAppState)
                // Rotate, flip
                AxisCmds().environmentObject(currentAppState)
            }
        }
    }
}

