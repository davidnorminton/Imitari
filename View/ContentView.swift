//
//  ContentView.swift
//  Imitari
//
//  Created by david norminton on 18/11/2023.
//

import SwiftUI


struct ContentView: View {

    @Binding var currentFile: String
    @Binding var currentDirectory: String
    @Binding var zoom: Double
    @Binding var currentFileNumber: Int
    @Binding var totalFiles: Int
    @Binding var aspectRatio: String
    @Binding var allFiles: Array<String>
    @Binding var isVertFlipped: Bool
    @Binding var isHorzFlipped: Bool
    
    @State private var showMenu: Bool = false
    
    @EnvironmentObject var slideShowState:  SlideShowState

    
    var aspectRatios = ["fill", "fit"]
    
    var body: some View {
        
        GeometryReader { proxy in
            if (!slideShowState.showSlideShow) {
                ZStack {

                    VStack {
                        if (currentFile.count > 0) {
                            MainImage(
                                currentFile: $currentFile,
                                zoom: $zoom,
                                aspectRatio: $aspectRatio,
                                isVertFlipped: $isVertFlipped,
                                isHorzFlipped: $isHorzFlipped
                            )
                        } else {
                            Home()
                        }
                    }
                    
                    MainHoverMenu(
                        currentFile: $currentFile,
                        currentDirectory: $currentDirectory,
                        zoom: $zoom,
                        currentFileNumber: $currentFileNumber,
                        totalFiles: $totalFiles,
                        showMenu: $showMenu,
                        allFiles: $allFiles,
                        isVertFlipped: $isVertFlipped,
                        isHorzFlipped: $isHorzFlipped
                    )
                    .environmentObject(slideShowState)
                    
                }
                .onHover { over in
                    if over && currentFile.count > 0 {
                        showMenu = true
                    } else {
                        showMenu = false
                    }
                }
            } else {
                ZStack {
                    SlideShow(
                        allFiles: $allFiles,
                        currentDirectory: $currentDirectory,
                        currentFile: $currentFile,
                        currentFileNumber: $currentFileNumber,
                        aspectRatio: $aspectRatio
                    )
                    .environmentObject(slideShowState)
                }
            }
        }
    }
}



