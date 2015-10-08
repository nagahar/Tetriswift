//
//  World.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class World {
    static let rows: Int = 20
    static let columns: Int = 10
    static var blocks: [[Block?]] = [[Block?]](count: World.rows, repeatedValue: [Block?](count: World.columns, repeatedValue: nil))
    
    static var sharedInstance: World {
        struct Static {
            static let instance: World = World()
        }
        
        return Static.instance
    }
    
    static func getInstance() -> World {
        return World.sharedInstance
    }
    
    static func getLowest(col: Int) -> Int {
        if (col < 0 || World.columns - 1 < col) {
            return -1
        }
        
        for i in 0..<World.rows {
            if let _ = World.blocks[i][col] {
                return i
            }
        }
        
        return World.rows
    }
    
    func putBlock(b: Block) {
        let p = Game.convert(b.frame.origin)
        World.blocks[p.row][p.column] = b
    }
    
    func removeLine() {
        var removeLine = [Int]()
        for i in 0..<World.rows {
            let row = World.blocks[i]
            var isLine = true
            for j in 0..<World.columns {
                if let _ = row[j] {
                } else {
                    isLine = false
                    break
                }
            }
            
            if (isLine) {
                removeLine.append(i)
            }
        }
        
        if (0 < removeLine.count) {
            var j: Int = removeLine.count - 1
            var d: CGFloat = 0
            for var i = World.rows - 1 ; -1 < i ; i-- {
                if (-1 < j && i == removeLine[j]) {
                    d++
                    j--
                    for c in 0..<World.columns {
                        if let col = World.blocks[i][c] {
                            col.dispose()
                            World.blocks[i][c] = nil
                        }
                    }
                } else {
                    for c in 0..<World.columns {
                        if let col = World.blocks[i][c] {
                            col.updateFromDiff(CGPointMake(0, d * Game.funit))
                            col.moveTo(self)
                            self.putBlock(col)
                        }
                    }
                }
            }
        }
    }
    
    func isGround(tuple: (row: Int, column: Int)) -> Bool {
        if (tuple.row == World.rows - 1) {
            return true
        } else if let _ = World.blocks[tuple.row + 1][tuple.column] {
            return true
        } else {
            return false
        }
    }
    
    func hasSpace(tuple: (row: Int, column: Int)) -> Bool {
        if (tuple.row < 0
            || tuple.column < 0
            || World.rows - 1 < tuple.row
            || World.columns - 1 < tuple.column)
        {
            return false
        } else if let _ = World.blocks[tuple.row][tuple.column] {
            return false
        } else {
            return true
        }
    }
}
