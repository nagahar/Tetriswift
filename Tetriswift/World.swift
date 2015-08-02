//
//  World.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class World {
    var cod : [[Bool]] = [[]]
    var width : CGFloat = 0.0
    var height : CGFloat = 0.0
    
    var wmax : Int = 0
    var hmax : Int = 0
    
    init (width : CGFloat, height : CGFloat) {
        self.width = width
        self.height = height
        wmax = self.getXindex(width)
        hmax = self.getYindex(height)
        self.cod = [[Bool]](count: wmax, repeatedValue: [Bool](count: hmax, repeatedValue: false))
        
        // bottom
        for i in 0..<wmax {
            cod[i][hmax - 1] = true
        }
    }
    
    private func getXindex(val : CGFloat) -> Int {
        return Int(val / TetrisView.UnitX)
    }
    
    private func getYindex(val : CGFloat) -> Int {
        return Int(val / TetrisView.UnitY)
    }
    
    func IsMovable(x: CGFloat, y: CGFloat) -> Bool {
        var xi = self.getXindex(x + TetrisView.UnitX)
        var yi = self.getYindex(y + TetrisView.UnitY)
        
        xi = xi < 0 ? 0 : xi
        xi = wmax - 1 < xi ? wmax - 1 : xi
        if (yi <= 0 || hmax - 1 <= yi ) {
            return false
        } else{
            return !self.cod[xi][yi]
            
        }
    }
   
}
