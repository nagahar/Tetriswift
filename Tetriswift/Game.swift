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
    static var width: CGFloat = 0
    static var height: CGFloat = 0
    let world: World
    
    init (width: CGFloat, height: CGFloat) {
        world = World.getInstance()
        let x = floor(width / CGFloat(World.columns))
        let y = floor(height / CGFloat(World.rows))
        Game.unit = x < y ? x : y
        print("unit = \(Game.unit)")
        Game.width = Game.unit * CGFloat(World.columns)
        Game.height = Game.unit * CGFloat(World.rows)
    }
    
    func start() {
        print("start")
    }
    
    static func getLowest(x: CGFloat) -> CGFloat {
        var lowest = CGFloat.max
        let xi = Game.convert(x)
        for var i = CGFloat(xi); i < Game.width; i += Game.unit {
            let t = CGFloat(World.getLowest(xi))
            if t < lowest && 0 < t {
                lowest = t
            }
        }
        
        return lowest == CGFloat.max ? -1 : lowest * Game.unit
    }
    
    static func isRange(p: CGPoint, s: CGSize) -> Bool {
        print("$$$$$$$$")
        print(p)
        print(s)
        print(Game.width)
        print(Game.height)
        return p.x + s.width <= Game.width &&
            p.y + s.height <= Game.height ? true : false
    }
    
    static func normalize(diff: CGPoint, v: UIView) -> CGPoint {
        let y = diff.y < 0 ? 0 : diff.y
        let orig = CGPointMake(diff.x + v.frame.origin.x ,y + v.frame.origin.y)
        if (Game.isRange(orig, s: v.frame.size)) {
            let p = Game.convert(orig)
            return CGPointMake(CGFloat(p.column) * Game.unit, CGFloat(p.row) * Game.unit)
        }
        
        return v.frame.origin
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