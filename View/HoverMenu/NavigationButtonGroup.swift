//
//  NavigationButtonsGroup.swift
//  Imitari
//
//  Created by david norminton on 21/11/2023.
//

import Foundation
import SwiftUI

struct NavigationButtonsGroup: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState

    var filesDir = FilesInDirectory()

    var body: some View {
        HStack {
            // goto prev file in directory
            Button {
                if (currentAppState.allFiles.count > 0) {
                    let fileCount = currentAppState.allFiles.count

                    if (currentAppState.currentFileNumber == 1) {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[fileCount - 1]
                        currentAppState.currentFileNumber = fileCount

                    } else {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[currentAppState.currentFileNumber - 2]
                        currentAppState.currentFileNumber -= 1
                    }
                }
            } label: {
                Image(systemName: "chevron.left")
            }
            .help("Previous file")

            // FilePosition / Total files
            Text(String(currentAppState.currentFileNumber) + " / " + String(currentAppState.totalFiles))
                .frame(width: 60)
            
            // Goto next file in directory
            Button {
                if (currentAppState.allFiles.count > 0) {
                    if (currentAppState.currentFileNumber == currentAppState.allFiles.count) {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[0]
                        currentAppState.currentFileNumber = 1
                    } else {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[currentAppState.currentFileNumber]
                        currentAppState.currentFileNumber += 1
                    }
                }
            } label: {
                Image(systemName: "chevron.right")
            }
            .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
            .padding(.leading, 5.0)
            .help("Next file")
        }
    }
}
