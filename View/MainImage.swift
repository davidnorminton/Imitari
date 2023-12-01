//
//  MainImage.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

struct MainImage: View {

    @EnvironmentObject var currentAppState: CurrentAppState

    var body: some View {
        if let cgUrl = currentAppState.cgUrl,
           let nsImage = NSImage(contentsOf: cgUrl) {
            let image = Image(nsImage: nsImage)
                .resizable()
                .scaledToFill()
                .scaleEffect(
                    x: currentAppState.isHorzFlipped ? -1 : 1,
                    y: currentAppState.isVertFlipped ? -1 : 1
                )
            
            switch currentAppState.aspectRatio {
            case "fit":
                return AnyView(image.frame(height: currentAppState.appHeight * CGFloat(currentAppState.zoom)))
            case "fill":
                return AnyView(image.frame(width: currentAppState.appWidth * CGFloat(currentAppState.zoom)))
            default:
                return AnyView(image.frame(height: currentAppState.appHeight * CGFloat(currentAppState.zoom)))
            }
        } else {
            return AnyView(Text("Unable to open file: \(currentAppState.currentFile)"))
        }
    }
}
