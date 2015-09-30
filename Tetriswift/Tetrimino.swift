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
    var bounds: CGRect = CGRectZero
    var dest: CGRect = CGRectZero
    
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
    }
    
    func updateFromDiff(diff: CGPoint) {
        for b in self.blocks {
            b.setDestinationFromDiff(diff)
        }
        
        let p = self.bounds.origin + diff
        self.dest = CGRectMake(p.x, p.y, 0, 0)
    }
    
    func sortDescBlocks() -> [Block] {
        return self.blocks.sort({(a: Block, b: Block) -> Bool in
            return (a.frame.origin.y > b.frame.origin.y)
        })
    }
    
    func moveTo(w: World) -> Bool {
        var isGround: Bool = false
        let s = self.sortDescBlocks()
        for b in s {
            if (b.hasUpdated()) {
                print("move from \(b.frame.origin)")
                b.moveTo(w)
                isGround = isGround || b.isGround
                b.reset()
            }
        }
        
        if (isGround) {
            for b in s {
                w.putBlock(b)
            }
        }
        
        return isGround
    }
    
    static let p_00: CGPoint = CGPointMake(0, 0)
    static let p_01: CGPoint = CGPointMake(0, Game.unit)
    static let p_10: CGPoint = CGPointMake(Game.unit, 0)
    static let p_11: CGPoint = CGPointMake(0, Game.unit)
    
    static func createO(tetrimino: Tetrimino) -> [Block]{
        var ret: [Block] = []
        //let c = UIColor.yellowColor()
        let c = UIColor.blueColor()
        ret.append(Block(o: p_00, c: c, t: tetrimino))
        ret.append(Block(o: p_01, c: c, t: tetrimino))
        ret.append(Block(o: p_10, c: c, t: tetrimino))
        ret.append(Block(o: p_11, c: c, t: tetrimino))
        return ret
    }
    
}

