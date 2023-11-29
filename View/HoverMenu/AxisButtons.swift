//
//  AxisButtons.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct AxisButtons: View {
    
    @Binding var isVertFlipped: Bool
    @Binding var isHorzFlipped: Bool

    
    var body: some View {
        
        
        Button {
            // rotate left
        } label: {
            Image(systemName: "rotate.left")
        }
        
        Button {
            // rotate right
        } label: {
            Image(systemName: "rotate.right")
        }
        
        Button {
            // flip vertical
            if isVertFlipped {
                isVertFlipped = false
            } else {
                isVertFlipped = true
            }
        } label: {
            Image(systemName: "arrow.up.and.down")
        }
        .help("Flip vertical")
        
        Button {
            // flip horizontal
            if isHorzFlipped {
                isHorzFlipped = false
            } else {
                isHorzFlipped = true
            }
        } label: {
            Image(systemName: "arrow.left.and.right")
        }
        .help("Flip horizontal")
        
    }
    
    
}
