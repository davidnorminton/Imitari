//
//  ScaleContent.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct ScaleContent: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState

    var body: some View {
        Button("Scale to fit") {
            currentAppState.aspectRatio = "fit"
        }

        Button("Scale to fill") {
            currentAppState.aspectRatio = "fill"
        }
    }
}
