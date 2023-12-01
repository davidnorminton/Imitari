//
//  MainImage.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

struct MainImage: View {

    @EnvironmentObject var currentAppState:  CurrentAppState

    
    var dirPath = DirectoryPath()

    var body: some View {
        let file = currentAppState.currentFile.removingPercentEncoding
        let url = URL(fileURLWithPath: file ?? currentAppState.currentFile.replacingOccurrences(of: "%20", with: " "))
        
        
        if let imageData = try? Data(contentsOf: url),
           let nsImage = NSImage(data: imageData) {
                let image = Image(nsImage: nsImage)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(
                        x: currentAppState.isHorzFlipped ? -1 : 1,
                        y: currentAppState.isVertFlipped ? -1 : 1
                    )
            
                switch currentAppState.aspectRatio {
                case "fit":
                    image.frame(height: currentAppState.appHeight * CGFloat(currentAppState.zoom))
                case "fill":
                    image.frame(width: currentAppState.appWidth * CGFloat(currentAppState.zoom))
                default:
                    image.frame(height: currentAppState.appHeight * CGFloat(currentAppState.zoom))
                }
        } else {
            AnyView(Text("Unable to open file: \(currentAppState.currentFile)"))
        }
    }
}
