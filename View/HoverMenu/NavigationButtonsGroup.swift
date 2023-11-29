//
//  NavigationButtonsGroup.swift
//  Imitari
//
//  Created by david norminton on 21/11/2023.
//

import Foundation
import SwiftUI

struct NavigationButtonsGroup: View {
    
    @Binding var currentFile: String
    @Binding var currentDirectory: String
    @Binding var currentFileNumber: Int
    @Binding var totalFiles: Int
    @Binding var allFiles: Array<String>

    var filesDir = FilesInDirectory()

    var body: some View {
        HStack {
            // goto prev file in directory
            Button {
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
            } label: {
                Image(systemName: "chevron.left")
            }
            .help("Previous file")

            // FilePosition / Total files
            Text(String(currentFileNumber) + " / " + String(totalFiles))
                .frame(width: 60)
            
            // Goto next file in directory
            Button {
                if (allFiles.count > 0) {
                    if (currentFileNumber == allFiles.count) {
                        currentFile = currentDirectory + "/" + allFiles[0]
                        currentFileNumber = 1
                    } else {
                        currentFile = currentDirectory + "/" + allFiles[currentFileNumber]
                        currentFileNumber += 1
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
