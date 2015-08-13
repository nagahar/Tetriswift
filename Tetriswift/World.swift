//
//  World.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class World {
    var blocks : [[Bool]] = [[]]
    var width : CGFloat = 0.0
    var height : CGFloat = 0.0
    
    var xlen : Int = 0
    var ylen : Int = 0
    
    init (width : CGFloat, height : CGFloat) {
        self.width = width
        self.height = height
        self.xlen = self.getIndex(width, unit: TetrisView.Unit.x)
        self.ylen = self.getIndex(height, unit: TetrisView.Unit.y)
        self.blocks = [[Bool]](count: xlen, repeatedValue: [Bool](count: ylen, repeatedValue: false))
    }
    
    private func getIndex(val : CGFloat, unit : CGFloat) -> Int {
        return Int(val / unit)
    }
    
    private func getIndexRect(o: CGRect) -> (x: Int, y: Int, width: Int, height: Int) {
        let xi = self.getIndex(o.origin.x, unit: TetrisView.Unit.x)
        let maxX = xi + Int(o.width / TetrisView.Unit.x)
        let yi = self.getIndex(o.origin.y, unit: TetrisView.Unit.y)
        let maxY = yi + Int(o.height / TetrisView.Unit.y)
        return (xi, yi, maxX, maxY)
    }
    
    func addBlock(o: CGRect) {
        let rect = getIndexRect(o)
        for i in rect.x..<rect.width {
            for j in rect.y..<rect.height {
                self.blocks[i][j] = true
            }
        }
    }
    
    func IsMovable(o: CGRect) -> Bool {
        let rect = getIndexRect(o)
        if (xlen <= rect.x || ylen <= rect.y) {
            println("Overflow**********")
            return false
        }
        
        for i in rect.x..<rect.width {
            for j in rect.y..<rect.height {
                if (self.blocks[i][j]) {
                    return false
                }
            }
        }
        
        return true
    }
    
}
