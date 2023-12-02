//
//  ImitariApp.swift
//  Imitari
//
//  Created by david norminton on 18/11/2023.
//

import SwiftUI
import Foundation

@main
struct ImitariApp: App {
   
    // EnviromentObject states
    @StateObject var currentAppState = CurrentAppState()
    @StateObject var slideShowState = SlideShowState()
    

    var body: some Scene {

        WindowGroup {
            ContentView()
                .environmentObject(currentAppState)
                .environmentObject(slideShowState)
                .onOpenURL(perform: { url in
                    currentAppState.setCurrentByChoice(path: url.path(), file: url)
                })
        }
        .commands {
            CommandGroup(before: CommandGroupPlacement.newItem) {
                CommandGroupButtons().environmentObject(currentAppState)
            }
            CommandMenu("Tools") {
                ToolsCmdGroup()
                    .environmentObject(currentAppState)
                    .environmentObject(slideShowState)
            }
        }
    }
}

