//
//  ZoomCmdsGroup.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct ZoomCmdsGroup: View {
    
    @Binding var zoom: Double
    
    var zoomState = Zoom()

    var body: some View {
        
        Button("Zoom in") {
            zoom  = zoomState.zoomIn(counter: zoom)
        }
        Button("Zoom out") {
            zoom = zoomState.zoomOut(counter: zoom)
        }
        Button("Reset zoom") {
            zoom = zoomState.reset()
        }
    }
}
