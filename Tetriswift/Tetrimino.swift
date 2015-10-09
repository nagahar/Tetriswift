//
//  Tetrimino.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Tetrimino: UIView {
    var dest: CGPoint = CGPointZero
    var type: TetriminoType = .None
    var game: Game!
    var blocks: [Block] = []
    
    static let p_00: CGPoint = CGPointMake(0, 0)
    static let p_01: CGPoint = CGPointMake(0, Game.funit)
    static let p_10: CGPoint = CGPointMake(Game.funit, 0)
    static let p_11: CGPoint = CGPointMake(Game.funit, Game.funit)
    
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
            return CGRectMake(0, 0, Game.funit * 2, Game.funit * 2)
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
    }
    
    func replace(parent: UIView, w: World) {
        self.removeFromSuperview()
        Tetrimino.reset(self, p: parent, w: w)
    }
    
    func moveTo(w: World) -> Bool {
        let ret = Util.moveTo(self,
            dest: self.dest,
            c:{() -> Bool in
                return !self.isOccupied(w) })
        return ret ? self.isGround(w) : false
    }
    
    func convert(b: Block) -> (Int, Int) {
        return Game.convert(b.locationInView(self))
    }
    
    func updateFromDiff(diff: CGPoint) {
        self.dest = Game.normalize(diff, v: self)
    }
    
    func isOccupied(w: World) -> Bool {
        return occupied({ b in
            let t = self.convert(b)
            return w.isOccupied(t.0, col: t.1)
        })
    }
    
    func occupied(c: (Block) -> Bool) -> Bool {
        var ret: Bool = false
        for b in self.blocks {
            ret = ret || c(b)
        }
        
        return ret
    }
    
    func isGround(w: World) -> Bool {
        return occupied({ b in
            let t = self.convert(b)
            return w.isOccupied(t.0 + 1, col: t.1)
        })
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
        let lowest = CGFloat(Game.getLowest(self.frame.origin.x))
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
