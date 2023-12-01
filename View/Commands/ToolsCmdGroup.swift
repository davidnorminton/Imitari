//
//  ToolsCmdGroup.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

struct ToolsCmdGroup: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState
    @EnvironmentObject var slideShowState:  SlideShowState

    var body: some View {
        // Next, previous
        Navigate().environmentObject(currentAppState)
        // slideshow controls
        SlideShowCmd().environmentObject(slideShowState)
        // Image zoom
        ZoomCmdsGroup().environmentObject(currentAppState)
        // Aspect ratio
        ScaleContent().environmentObject(currentAppState)
        // Rotate, flip
        AxisCmds().environmentObject(currentAppState)
    }
}
