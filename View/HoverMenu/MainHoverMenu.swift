//
//  MainHoverMenu.swift
//  Imitari
//
//  Created by david norminton on 20/11/2023.
//

import Foundation
import SwiftUI


struct MainHoverMenu: View {
    @Binding var currentFile: String
    @Binding var currentDirectory: String
    @Binding var zoom: Double
    @Binding var currentFileNumber: Int
    @Binding var totalFiles: Int
    @Binding var showMenu: Bool
    @Binding var allFiles: Array<String>
    @Binding var showSlideShow: Bool
    @Binding var isVertFlipped: Bool
    @Binding var isHorzFlipped: Bool

    var aspectRatios = ["fill", "fit"]

    var body: some View {
        if (showMenu) {
            VStack {
                VStack {
                    HStack {
              
                        NavigationButtonsGroup(
                            currentFile: $currentFile,
                            currentDirectory: $currentDirectory,
                            currentFileNumber: $currentFileNumber,
                            totalFiles: $totalFiles,
                            allFiles: $allFiles
                        )
                        
                        Button {
                            showSlideShow = true
                        } label: {
                            Image(systemName: "play")
                        }
                        .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                        .help("Play slide show")
                        
                        ZoomButtonsGroup(zoom: $zoom)
                        
                        AxisButtons(isVertFlipped: $isVertFlipped, isHorzFlipped: $isHorzFlipped)

                    }
                    .padding([.bottom], 5)
                }
                .frame(maxWidth: 444, maxHeight: 30, alignment: .bottom)
                .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                .cornerRadius(5)
                .padding(15.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
