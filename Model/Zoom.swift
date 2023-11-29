//
//  Zoom.swift
//  Imitari
//
//  Created by david norminton on 21/11/2023.
//

import Foundation


class Zoom {
    var zoomIncrement = 0.10
    
    func zoomIn (counter: Double) -> Double {
        return counter + zoomIncrement
    }
    
    func zoomOut (counter: Double) -> Double {
        if (counter > zoomIncrement) {
            return counter - zoomIncrement
        }
        
        return counter
    }
    
    func reset () -> Double {
        return 1.00
    }
}
