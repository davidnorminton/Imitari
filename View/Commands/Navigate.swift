//
//  Navigate.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct Navigate: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState
    
    var body: some View {
        VStack {
            Button("Next File") {
                if (currentAppState.allFiles.count > 0) {
                    if (currentAppState.currentFileNumber == currentAppState.allFiles.count) {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[0]
                        currentAppState.currentFileNumber = 1
                    } else {
                        currentAppState.currentFile = currentAppState.currentDirectory + "/" + currentAppState.allFiles[currentAppState.currentFileNumber]
                        currentAppState.currentFileNumber += 1
                    }
                }
            }
            .keyboardShortcut(">")
            
            Button("Previous File") {
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
            }
            .keyboardShortcut("<")
            
            Divider()
        }
    }
}
