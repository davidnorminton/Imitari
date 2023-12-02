//
//  AppSettings.swift
//  Imitari
//
//  Created by david norminton on 23/11/2023.
//
import SwiftUI
import Foundation

struct AppSettings: View {
    
    @EnvironmentObject var slideShowState:  SlideShowState

    var body: some View {
        VStack{
            List {
                HStack {
                    Text("Interval")
                    Button {
                        if slideShowState.slideShowInterval > 1 {
                            slideShowState.slideShowInterval -= 1
                        }
                    } label: {
                        Image(systemName: "minus")
                    }
                    .background(Color(hue: 1.0, saturation: 0.076, brightness: 0.196))
                    .padding(.leading, 5.0)
                    
                    Text (String(slideShowState.slideShowInterval) + " s")
                    
                    Button {
                        slideShowState.slideShowInterval += 1
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
