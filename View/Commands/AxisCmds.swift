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
                
            }
            
            Button("Rotate right") {
                
            }
            
            Button("Flip vertical") {
                // flip vertical
                if currentAppState.isVertFlipped {
                    currentAppState.isVertFlipped = false
                } else {
                    currentAppState.isVertFlipped = true
                }
            }
            
            Button("Flip horizonatal") {
                // flip horizontal
                if currentAppState.isHorzFlipped {
                    currentAppState.isHorzFlipped = false
                } else {
                    currentAppState.isHorzFlipped = true
                }
            }
        }
    }
}
