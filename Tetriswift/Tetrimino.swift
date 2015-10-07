//
//  Tetrimino.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Tetrimino: UIView {
    var type: TetriminoType = .None
    var game: Game!
    var blocks: [Block] = []
    var isStopped: Bool = false
    var dest: CGPoint = CGPointZero
    
    static let p_00: CGPoint = CGPointMake(0, 0)
    static let p_01: CGPoint = CGPointMake(0, Game.unit)
    static let p_10: CGPoint = CGPointMake(Game.unit, 0)
    static let p_11: CGPoint = CGPointMake(Game.unit, Game.unit)
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(type: TetriminoType = .None, game: Game) {
        self.type = type
        self.game = game
        super.init(frame: Tetrimino.getSize(type))
        self.blocks = Tetrimino.create(self)
        for b in self.blocks {
            self.addSubview(b)
        }
        
        self.addDoubleTap("doubleTapped:")
        self.backgroundColor = UIColor.yellowColor()
    }
    
    deinit {
        dispose()
    }
    
    private static func getSize(type: TetriminoType) -> CGRect {
        switch type {
        case .O:
            return CGRectMake(0, 0, Game.unit * 2, Game.unit * 2)
        case .I:
            return CGRectZero
        case .S:
            return CGRectZero
        case .Z:
            return CGRectZero
        case .J:
            return CGRectZero
        case .L:
            return CGRectZero
        case .T:
            return CGRectZero
        case .None:
            return CGRectZero
        }
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
        self.removeFromSuperview()
        for b in self.blocks {
            b.removeFromSuperview()
        }
        
        self.blocks = []
        NSLog("%s, %d", __FUNCTION__, __LINE__)
    }
    
    func replace(parent: UIView, w: World) {
        self.removeFromSuperview()
        Tetrimino.reset(self, p: parent, w: w)
    }
    
    func updateFromDiff(diff: CGPoint) {
        self.dest = Game.normalize(diff, v: self)
    }
    
    func hasSpace(w: World) -> Bool {
        var ret: Bool = false
        for b in self.blocks {
            ret = ret || w.hasSpace(convert(b))
        }
        
        return ret
    }
    
    func isGround(w: World) -> Bool {
        var ret: Bool = false
        for b in self.blocks {
            ret = ret || w.isGround(convert(b))
        }
        
        return ret
    }
    
    func convert(b: Block) -> (Int, Int) {
        return Game.convert(b.locationInView(self))
    }
    
    func moveTo(w: World) -> Bool {
        var isGround: Bool = false
        if (Util.hasUpdated(self.dest, v: self)) {
            print("move from \(self.frame.origin)")
            print("dest: \(self.dest)")
            if (self.hasSpace(w)) {
                print("MMMMMMMMMMMMMMMM")
                Util.translate(self.dest - self.frame.origin, v: self)
                isGround = self.isGround(w)
            }
        }
        
        return isGround
    }
    
    func sortDesc() -> [Block] {
        return self.blocks.sort({(a: Block, b: Block) -> Bool in
            return (a.frame.origin.y > b.frame.origin.y)
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("@@@@@@@@@")
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.update(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.update(touches, withEvent: event)
    }
    
    func update(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            self.updateFromDiff(touch.locationInView(self.superview) - self.frame.origin)
        }
    }
    
    static func createO(tetrimino: Tetrimino) -> [Block] {
        var block: [Block] = []
        //let c = UIColor.yellowColor()
        let c = UIColor.blueColor()
        block.append(Block(o: p_00, c: c, t: tetrimino))
        block.append(Block(o: p_01, c: c, t: tetrimino))
        block.append(Block(o: p_10, c: c, t: tetrimino))
        block.append(Block(o: p_11, c: c, t: tetrimino))
        return block
    }
    
    
    static func reset(t: Tetrimino, p: UIView, w: World) {
        for b in t.blocks {
            b.frame.origin = b.locationInView(t)
            b.removeFromSuperview()
            p.addSubview(b)
            w.putBlock(b)
            print("@@@@@@@\(b.frame.origin)")
        }
    }
    
    func doubleTapped(sender: UITapGestureRecognizer) {
        print("DDDDDDDDDDDDDDDD")
        let lowest = Game.getLowest(self.frame.origin.x)
        print("CCCCCCCCCC tapped \(lowest)")
        if (0 < lowest) {
            self.updateFromDiff(CGPointMake(0, lowest - self.frame.height - self.frame.origin.y))
        }
    }
    
    func addDoubleTap(selector: Selector) {
        let doubleTap = UITapGestureRecognizer(target: self, action: selector)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func rightRotate() {
        
    }
    
    func leftRotate() {
        
    }
}
