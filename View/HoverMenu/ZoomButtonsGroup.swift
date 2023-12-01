//
//  ZoomButtonsGroup.swift
//  Imitari
//
//  Created by david norminton on 21/11/2023.
//

import Foundation
import SwiftUI

struct ZoomButtonsGroup: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState

    var zoomState = Zoom()

    var body: some View {
        HStack {
            // Zoom out
            Button {
                currentAppState.zoom = zoomState.zoomOut(counter: currentAppState.zoom)
            } label: {
                Image(systemName: "minus.magnifyingglass")
            }
            .help("Zoom out")

            
            // Rest to normal
            Button {
                currentAppState.zoom = zoomState.reset()
            } label: {
                Image(systemName: "dot.arrowtriangles.up.right.down.left.circle")
            }
            .help("Zoom reset")
            
            // zoom in
            Button {
                currentAppState.zoom  = zoomState.zoomIn(counter: currentAppState.zoom)
            } label: {
                Image(systemName: "plus.magnifyingglass")
            }
            .help("Zoom in")
        }
    }
}
