//
//  Home.swift
//  Imitari
//
//  Created by david norminton on 20/11/2023.
//

import Foundation
import SwiftUI

struct Home: View {
    
    var body: some View {
        HStack {
            VStack {
                Text("Imatari")
                    .font(
                        .system(size: 34)
                        .weight(.heavy)
                    )
                    .padding(22)
                Text("Greatest image viewer in the WORLD!")
                    .font(
                        .system(size: 18)
                        .weight(.light)
                        .italic()
                    )
                    .foregroundStyle(.gray)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
