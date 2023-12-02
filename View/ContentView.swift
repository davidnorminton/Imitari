//
//  ContentView.swift
//  Imitari
//
//  Created by david norminton on 18/11/2023.
//

import SwiftUI


struct ContentView: View {
        
    @EnvironmentObject var currentAppState:  CurrentAppState
    @EnvironmentObject var slideShowState:  SlideShowState

    
    var aspectRatios = ["fill", "fit"]
    
    var body: some View {
        
        GeometryReader { proxy in
            if (!slideShowState.showSlideShow) {
                ZStack {

                    VStack {
                        if (currentAppState.currentFile.count > 0) {
                            MainImageView().environmentObject(currentAppState)
                        } else {
                            Home()
                        }
                    }
                    
                    MainHoverMenu()
                        .environmentObject(currentAppState)
                        .environmentObject(slideShowState)
                    
                }
                .onHover { over in
                    if over && currentAppState.currentFile.count > 0 {
                        currentAppState.showMenu = true
                    } else {
                        currentAppState.showMenu = false
                    }
                }
            } else {
                ZStack {
                    SlideShow()
                        .environmentObject(currentAppState)
                        .environmentObject(slideShowState)
                }
            }
        }
    }
}



