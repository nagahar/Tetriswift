//
//  Game.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/16.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Game {
    static var unit: CGFloat = 0
    let world: World
    let width: CGFloat
    let height: CGFloat
    
    init (width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        world = World.getInstance()
        let x = floor(width / CGFloat(World.columns))
        let y = floor(height / CGFloat(World.rows))
        Game.unit = x < y ? x : y
        print("unit = \(Game.unit)")
    }
    
    func start() {
        print("start")
    }
    
    static func getTopY(x: CGFloat) -> CGFloat {
        let row = World.getTopRow(Game.convert(x))
        return CGFloat(row) * Game.unit
    }
    
    static func normalize(dest: CGPoint, current: CGPoint) -> CGPoint {
        let y = dest.y < current.y ? current.y : dest.y
        return Game.normalize(CGPointMake(dest.x, y))
    }
    
    static func normalize(dest: CGPoint) -> CGPoint {
        let p = Game.convert(dest)
        return CGPointMake(CGFloat(p.column) * Game.unit, CGFloat(p.row) * Game.unit)
    }
    
    static func convert(val: CGPoint) -> (row: Int, column: Int) {
        var row = convert(val.y)
        var col = convert(val.x)
        if (World.rows - 1 < row) {
            row = World.rows - 1
        } else if (row < 0) {
            row = 0
        } else {
            // nothing
        }
        
        if (World.columns - 1 < col) {
            col = World.columns - 1
        } else if (col < 0) {
            col = 0
        } else {
            // nothing
        }
        
        return (row, col)
    }
    
    static func convert(val: CGFloat) -> Int {
        return Int(floor(val / Game.unit))
    }
}