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
    
    func putTetrimino(tetrimino: Tetrimino) {
        for b in tetrimino.blocks {
                b.stop()
            let p = b.origin_w
            World.blocks[p.row][p.column] = b
        }
        
        /*
        let rect = convertRect(t.frame)
        for i in rect.y..<rect.height {
        for j in rect.x..<rect.width {
        let b = Block()
        b.tetris = t
        self.blocks[i][j] = b
        }
        }
        */
    }
    
    func removeLine() {
        /*
        for i in 0..<self.blocks.count {
        var isRemoved: Bool = true
        var tetrises: [TetrisView] = []
        for j in 0..<self.blocks[i].count {
        isRemoved = isRemoved && self.blocks[i][j].isExist
        tetrises.append(self.blocks[i][j].tetris)
        }
        
        if (isRemoved) {
        for t in tetrises {
        // tetrisオブジェクトの対応する行を消す(factoryを使ってコピーし、分割する)
        // 上にあるtetrisオブジェクトを一括して下に移動するようにdestを変更する
        }
        }
        }
        */
        
    }
    
    func isMovable(tuple: (row: Int, column: Int)) -> Bool {
        if (tuple.row<World.rows && tuple.column < World.columns) {
            if let b = World.blocks[tuple.row][tuple.column] {
                return false
            }
        }
        
        return true
    }
}
