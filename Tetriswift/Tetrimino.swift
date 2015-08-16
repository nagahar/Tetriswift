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
        
    }
    
    func update(dest: CGPoint) {
        for b in self.blocks {
            b.setDestination(dest)
        }
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

