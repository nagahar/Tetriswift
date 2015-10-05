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
    
    static func getLowest(x: CGFloat) -> CGFloat {
        let row = World.getLowest(Game.convert(x))
        return CGFloat(row) * Game.unit
    }
    
    static func normalize(diff: CGPoint, b: Block) -> CGPoint {
        let y = diff.y < 0 ? 0 : diff.y
        let p = Game.convert(CGPointMake(diff.x + b.frame.origin.x ,y + b.frame.origin.y))
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