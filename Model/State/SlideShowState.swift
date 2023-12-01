//
//  SlideShowState.swift
//  Imitari
//
//  Created by david norminton on 01/12/2023.
//

import Foundation
import SwiftUI

// new class Theme inherting from ObservableObject
final class SlideShowState: ObservableObject {
    @Published var showSlideShow: Bool = false
    @Published var slideShowInterval: Int = 3
}
