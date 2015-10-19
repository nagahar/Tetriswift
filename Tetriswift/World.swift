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
                        if let b = World.blocks[i][c] {
                            b.dispose()
                            World.blocks[i][c] = nil
                        }
                    }
                } else {
                    for c in 0..<World.columns {
                        if let b = World.blocks[i][c] {
                            b.moveTo(self, dest: CGPointMake(0, d * Game.funit) + b.frame.origin)
                            self.putBlock(b)
                        }
                    }
                }
            }
        }
    }
    
    private func isInRange(row: Int, col: Int) -> Bool {
        return 0 <= row && row < World.rows
            && 0 <= col && col < World.columns
    }
    
    func isOccupiedAndGrounded(var row: Int, col: Int) -> (isOccupied: Bool, isGrounded: Bool) {
        let oc = isInRange(row, col: col) ? World.blocks[row][col] != nil : true
        row = row + 1
        let gr = isInRange(row, col: col) ? World.blocks[row][col] != nil : true
        return (oc, gr)
    }
}
