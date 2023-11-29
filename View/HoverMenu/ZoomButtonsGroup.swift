//
//  ZoomButtonsGroup.swift
//  Imitari
//
//  Created by david norminton on 21/11/2023.
//

import Foundation
import SwiftUI

struct ZoomButtonsGroup: View {
    
    @Binding var zoom: Double
    
    var zoomState = Zoom()

    var body: some View {
        HStack {
            // Zoom out
            Button {
                zoom = zoomState.zoomOut(counter: zoom)
            } label: {
                Image(systemName: "minus.magnifyingglass")
            }
            .help("Zoom out")

            
            // Rest to normal
            Button {
                zoom = zoomState.reset()
            } label: {
                Image(systemName: "dot.arrowtriangles.up.right.down.left.circle")
            }
            .help("Zoom reset")
            
            // zoom in
            Button {
                zoom  = zoomState.zoomIn(counter: zoom)
            } label: {
                Image(systemName: "plus.magnifyingglass")
            }
            .help("Zoom in")
        }
    }
}
