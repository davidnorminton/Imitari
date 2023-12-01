//
//  CurrentAppState.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

final class CurrentAppState: ObservableObject {
    @Published var currentFile: String = ""
    @Published var currentDirectory: String = ""
    @Published var currentFileNumber: Int = 1
    @Published var allFiles = [String]()
    @Published var totalFiles: Int = 1
    @Published var zoom: Double = 1.00
    @Published var aspectRatio = "fit"
    @Published var isVertFlipped = false
    @Published var isHorzFlipped = false
    @Published var showMenu = false
}

