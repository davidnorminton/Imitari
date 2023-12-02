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
                currentAppState.nextFile()
            }
            .keyboardShortcut(">")
            
            Button("Previous File") {
                currentAppState.previousFile()
            }
            .keyboardShortcut("<")
            
            Divider()
        }
    }
}
