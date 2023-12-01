//
//  CommandGroupButtons.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

struct CommandGroupButtons: View {
    
    @EnvironmentObject var currentAppState:  CurrentAppState
    @State private var importing = false

    var body: some View {
        Button("Open image or directory") {
            importing = true
            currentAppState.isVertFlipped = false
            currentAppState.isHorzFlipped = false
        }
        .fileImporter(
            isPresented: $importing,
            allowedContentTypes: [.png, .jpeg, .gif, .directory]
        ) { result in
            switch result {
            case .success(let file):
                let filePath: String = file.path()
                currentAppState.setCurrentState(path: filePath, file: file)
                file.stopAccessingSecurityScopedResource()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
