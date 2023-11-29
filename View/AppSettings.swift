//
//  AppSettings.swift
//  Imitari
//
//  Created by david norminton on 23/11/2023.
//
import SwiftUI
import Foundation

struct AppSettings: View {
    
    @Binding var slideShowInterval: Int
    
    var body: some View {
        VStack{
            List {
                HStack {
                    Text("Interval")
                    Button {
                        if slideShowInterval > 1 {
                            slideShowInterval -= 1
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                    .padding(.leading, 5.0)
                    
                    Text (String(slideShowInterval) + " s")
                    
                    Button {
                        slideShowInterval += 1
                    } label: {
                        Image(systemName: "plus")
                    }
                    .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                    .padding(.leading, 5.0)
                }
            }
        }
        .frame(minWidth: 300, minHeight: 200)
    }
}
