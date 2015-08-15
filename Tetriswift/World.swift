//
//  World.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class World {
    static let unit: CGFloat = 50.0
    var blocks: [[Block?]] = [[]]
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    init () {
    }
    
    init (width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
        var xlen = self.convert(width)
        var ylen = self.convert(height)
        self.blocks = [[Block?]](count: ylen, repeatedValue: [Block?](count: xlen, repeatedValue: nil))
    }
    
    func translate(p: CGPoint, view: UIView) {
        view.transform = CGAffineTransformTranslate(view.transform, p.x , p.y)
    }
    
    private func convert(val: CGPoint) -> (Int, Int) {
        return (convert(val.x), convert(val.y))
    }
    
    private func convert(val: CGFloat) -> Int {
        return Int(val / World.unit)
    }
    
    private func convert(o: CGRect) -> (x: Int, y: Int, maxX: Int, maxY: Int) {
        let xi = self.convert(o.origin.x)
        let maxX = xi + convert(o.width)
        let yi = self.convert(o.origin.y)
        let maxY = yi + convert(o.height)
        return (xi, yi, maxX, maxY)
    }
    
    func normalize(p: CGFloat, max: CGFloat) -> CGFloat {
        let ret = World.unit * floor(p / World.unit)
        if (ret < 0) {
            return 0
        } else if (max < ret) {
            return -1
        } else {
            return ret
        }
    }
    
    func putTetrimino(tetrimino: Tetrimino) {
        for b in tetrimino.blocks {
            let p = convert(b.frame.origin)
            self.blocks[p.1][p.0] = b
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
    
    
    func IsMovable(o: CGRect) -> Bool {
        let tuple = convert(o)
        if (self.blocks.count < tuple.maxY || self.blocks.first!.count < tuple.maxX) {
            println("Overflow**********")
            return false
        }
        
        for i in tuple.y..<tuple.maxY {
            for j in tuple.x..<tuple.maxX {
                if let b = self.blocks[i][j] {
                    return false
                }
            }
        }
        
        return true
    }
    
}
