//
//  ZoomCmdsGroup.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct ZoomCmdsGroup: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState

    var zoomState = Zoom()

    var body: some View {
        
        Button("Zoom in") {
            currentAppState.zoom  = zoomState.zoomIn(counter: currentAppState.zoom)
        }
        Button("Zoom out") {
            currentAppState.zoom = zoomState.zoomOut(counter: currentAppState.zoom)
        }
        Button("Reset zoom") {
            currentAppState.zoom = zoomState.reset()
        }
    }
}
