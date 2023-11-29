//
//  ScaleContent.swift
//  Imitari
//
//  Created by david norminton on 25/11/2023.
//

import Foundation
import SwiftUI

struct ScaleContent: View {
    
    @Binding var aspectRatio: String
    
    var body: some View {
        Button("Scale to fit") {
            aspectRatio = "fit"
        }

        Button("Scale to fill") {
            aspectRatio = "fill"
        }
    }
}
