//
//  Game.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/16.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Game {
    static var unit: Int = 0
    static var funit: CGFloat = 0
    static var root: UIView?
    let xinit: CGFloat = 5
    let yinit: CGFloat = 0
    let world: World
    
    init (width: CGFloat, height: CGFloat) {
        world = World.getInstance()
        let x = Int(width) / World.columns
        let y = Int(height) / World.rows
        Game.unit = x < y ? x : y
        Game.funit = CGFloat(Game.unit)
        print("unit = \(Game.unit)")
        let w = Game.unit * World.columns
        let h = Game.unit * World.rows
        Game.root = UIView(frame: CGRectMake(xinit, yinit, CGFloat(w), CGFloat(h)))
        Game.root!.backgroundColor = UIColor.whiteColor()
        print(Game.root!.frame.size)
    }
    
    func start() {
        print("start")
    }
    
    static func getLowest(x: CGFloat) -> Int {
        var lowest = Int.max
        let xi = Game.convert(x)
        for var i = xi; i < Int(Game.root!.frame.width); i += Game.unit {
            let t = World.getLowest(xi)
            if t < lowest && 0 < t {
                lowest = t
            }
        }
        
        return lowest == Int.max ? -1 : lowest * Game.unit
    }
    
    static func isRange(p: CGPoint, s: CGSize) -> Bool {
        return p.x + s.width <= Game.root!.frame.width &&
            p.y + s.height <= Game.root!.frame.height ? true : false
    }
    
    static func isRange(col: Int, row: Int, s: CGSize) -> Bool {
        return col + Int(s.width) / Game.unit <= World.columns && row + Int(s.height) / Game.unit <= World.rows
    }
    
    static func normalize(diff: CGPoint, v: UIView) -> CGPoint {
        let y = diff.y < 0 ? 0 : diff.y
        let orig = CGPointMake(diff.x + v.frame.origin.x ,y + v.frame.origin.y)
        let p = Game.convert(orig)
        if (isRange(p.column, row: p.row, s: v.frame.size)) {
            return CGPointMake(CGFloat(p.column * Game.unit), CGFloat(p.row * Game.unit))
        } else {
            return v.frame.origin
        }
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
        return Int(val) / Game.unit
    }
    
    static func hasUpdated(p: CGPoint, v: UIView) -> Bool {
        return !CGPointEqualToPoint(v.frame.origin, p)
    }
    
    static func translate(p: CGPoint, v: UIView) {
        v.transform = CGAffineTransformTranslate(v.transform, p.x , p.y)
    }
}