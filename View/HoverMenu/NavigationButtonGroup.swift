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
                currentAppState.nextFile()
            } label: {
                Image(systemName: "chevron.left")
            }
            .help("Previous file")

            // FilePosition / Total files
            Text(String(currentAppState.currentFileNumber) + " / " + String(currentAppState.totalFiles))
                .frame(width: 60)
            
            // Goto next file in directory
            Button {
                currentAppState.previousFile()
            } label: {
                Image(systemName: "chevron.right")
            }
            .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
            .padding(.leading, 5.0)
            .help("Next file")
        }
    }
}
