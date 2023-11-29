//
//  Navigate.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct Navigate: View {
    
    @Binding var allFiles: [String]
    @Binding var currentFileNumber: Int
    @Binding var currentFile: String
    @Binding var currentDirectory: String
    
    var body: some View {
        VStack {
            Button("Next File") {
                if (allFiles.count > 0) {
                    if (currentFileNumber == allFiles.count) {
                        currentFile = currentDirectory + "/" + allFiles[0]
                        currentFileNumber = 1
                    } else {
                        currentFile = currentDirectory + "/" + allFiles[currentFileNumber]
                        currentFileNumber += 1
                    }
                }
            }
            .keyboardShortcut(">")
            
            Button("Previous File") {
                if (allFiles.count > 0) {
                    let fileCount = allFiles.count
                    if (currentFileNumber == 1) {
                        currentFile = currentDirectory + "/" + allFiles[fileCount - 1]
                        currentFileNumber = fileCount

                    } else {
                        currentFile = currentDirectory + "/" + allFiles[currentFileNumber - 2]
                        currentFileNumber -= 1
                    }
                }
            }
            .keyboardShortcut("<")
            
            Divider()
        }
    }
}
