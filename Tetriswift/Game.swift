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
        Game.unit = floor(width / CGFloat(World.columns))
        println("unit = \(Game.unit)")
    }
    
    func start() {
        println("start")
    }
    
    static func convert(val: CGPoint) -> (row: Int, column: Int) {
        return (convert(val.y), convert(val.x))
    }
    
    static func convert(val: CGFloat) -> Int {
        return Int(floor(val / Game.unit))
    }
    
    static func convert(o: CGRect) -> (row: Int, column: Int, height: Int, width: Int) {
        let xi = self.convert(o.origin.x)
        let maxX = convert(o.width)
        let yi = self.convert(o.origin.y)
        let maxY = convert(o.height)
        return (yi, xi, maxY, maxX)
    }
}