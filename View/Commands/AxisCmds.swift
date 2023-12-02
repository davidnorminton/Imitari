//
//  AxisCmds.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

struct AxisCmds: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState
    
    var body: some View {
        VStack {
            Button("Rotate left") {
                currentAppState.rotateLeft()
            }
            
            Button("Rotate right") {
                currentAppState.rotateRight()
            }
            
            Button("Flip vertical") {
                currentAppState.flipVertical()
            }
            
            Button("Flip horizonatal") {
                currentAppState.flipHorizontal()
            }
        }
    }
}
