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
    let blocks: [Block]
    var isStopped: Bool = false
    
    init (t: TetriminoType = .None) {
        self.type = t
        self.blocks = t.create()
    }
    
    var Size: CGSize {
        get{
            return type.getSize()
        }
    }
}

enum TetriminoType {
    case None
    case O
    case I
    case S
    case Z
    case J
    case L
    case T
    
    func create() -> [Block] {
        switch self {
        case .O:
            return createO()
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
    
    func getSize() -> CGSize {
        let u = World.unit
        switch self {
        case .O:
            return CGSizeMake(2 * u, 2 * u)
        case .I:
            return CGSizeZero
        case .S:
            return CGSizeZero
        case .Z:
            return CGSizeZero
        case .J:
            return CGSizeZero
        case .L:
            return CGSizeZero
        case .T:
            return CGSizeZero
        case .None:
            return CGSizeZero
        }
    }
    
    private func createO() -> [Block]{
        var ret: [Block] = []
        let u = World.unit
        //let c = UIColor.yellowColor()
        let c = UIColor.blueColor()
        ret.append(Block(o: CGPointMake(0, 0), c: c))
        ret.append(Block(o: CGPointMake(0, u), c: c))
        ret.append(Block(o: CGPointMake(u, 0), c: c))
        ret.append(Block(o: CGPointMake(u, u), c: c))
        return ret
    }
}