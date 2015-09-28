//
//  Tetrimino.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Tetrimino {
    let type: TetriminoType
    let game: Game
    var blocks: [Block] = []
    var isStopped: Bool = false
    var size: CGSize = CGSizeZero
    var point: CGPoint = CGPointZero
    
    init(type: TetriminoType = .None, game: Game) {
        self.type = type
        self.game = game
        self.blocks = Tetrimino.create(self)
    }
    
    deinit {
        dispose()
    }
    
    static func create(tetrimino: Tetrimino) -> [Block] {
        switch tetrimino.type {
        case .O:
            return createO(tetrimino)
        case .I:
            return ([])
        case .S:
            return ([])
        case .Z:
            return ([])
        case .J:
            return ([])
        case .L:
            return ([])
        case .T:
            return ([])
        case .None:
            return ([])
        }
    }
    
    func dispose() {
        self.blocks = []
        self.size = CGSizeZero
        self.point = CGPointZero
    }
    
    func update(dest: CGPoint) {
        let diff = dest - self.point
        print(self.point)
        print(diff)
        self.updateFromDiff(diff)
    }
    
    func updateFromDiff(diff: CGPoint) {
        
        for b in self.blocks {
            // check negative value
            let p = b.frame.origin + diff
            if (p.x < 0 || p.y < 0) {
                return
            }
        }
        
        for b in self.blocks {
            b.setDestinationFromDiff(diff)
        }
        
        self.point = self.point + diff
        print("%%%%%%%%%%%%%")
        print(self.point)
    }
    
    func sortBlocks() -> [Block] {
        return self.blocks.sort({(a: Block, b: Block) -> Bool in
            return (a.frame.origin.y < b.frame.origin.y)
        })
    }
    
    func moveTo(w: World) -> Bool {
        var isBound: Bool = false
        let s = sortBlocks()
        for b in s {
            if (b.hasUpdated()) {
                b.moveTo(w)
                print("move from \(b.frame.origin)")
                if (b.isBound) {
                    print("Stop \(b.frame.origin)")
                    w.putBlock(b)
                }
                
                isBound = isBound || b.isBound
                b.reset()
            }
        }
        
        if (isBound) {
            for b in s {
                w.putBlock(b)
            }
        }
        
        return isBound
    }
    
    
    static func createO(tetrimino: Tetrimino) -> [Block]{
        var ret: [Block] = []
        let u = Game.unit
        //let c = UIColor.yellowColor()
        let c = UIColor.blueColor()
        ret.append(createBlock(CGPointMake(0, 0), color: c, tetrimino: tetrimino))
        ret.append(createBlock(CGPointMake(0, u), color: c, tetrimino: tetrimino))
        ret.append(createBlock(CGPointMake(u, 0), color: c, tetrimino: tetrimino))
        ret.append(createBlock(CGPointMake(u, u), color: c, tetrimino: tetrimino))
        tetrimino.size = CGSizeMake(2 * u, 2 * u)
        return ret
    }
    
    static func createBlock(origin: CGPoint, color: UIColor, tetrimino: Tetrimino) -> Block {
        return Block(o: origin, c: color, t: tetrimino)
    }
    
}

