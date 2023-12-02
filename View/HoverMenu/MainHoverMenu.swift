//
//  MainHoverMenu.swift
//  Imitari
//
//  Created by david norminton on 20/11/2023.
//

import Foundation
import SwiftUI


struct MainHoverMenu: View {

    
    @EnvironmentObject var currentAppState:  CurrentAppState
    @EnvironmentObject var slideShowState:  SlideShowState

    var aspectRatios = ["fill", "fit"]

    var body: some View {
        if (currentAppState.showMenu) {
            VStack {
                VStack {
                    HStack {
              
                        NavigationButtonsGroup()
                            .environmentObject(currentAppState)
                        
                        Button {
                            slideShowState.showSlideShow = true
                        } label: {
                            Image(systemName: "play")
                        }
                        .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                        .help("Play slide show")
                        .padding([.trailing, .leading], 10)
                        
                        ZoomButtonsGroup()
                            .environmentObject(currentAppState)
                        
                    }
                    .padding([.bottom], 5)
                }
                .frame(maxWidth: 316, maxHeight: 30, alignment: .bottom)
                .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                .cornerRadius(5)
                .padding(15.0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
