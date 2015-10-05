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
        self.userInteractionEnabled = true
    }
    
    deinit {
        dispose(self)
    }
    
    private static func getSize(type: TetriminoType) -> CGRect {
        switch type {
        case .O:
            return CGRectMake(0, 0, Game.unit, Game.unit)
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
    
    func dispose(parent: UIView) {
        for b in self.blocks {
            parent.addSubview(b)
        }
        
        self.blocks = []
    }
    
    func updateFromDiff(diff: CGPoint) {
        self.dest = self.frame.origin + diff
    }
    
    func moveTo(w: World) -> Bool {
        var isGround: Bool = false
        if (Util.hasUpdated(self.dest, v: self)) {
            print("move from \(self.frame.origin)")
            print("dest: \(self.dest)")
            let p = Game.convert(self.dest)
            if (w.hasSpace(p)) {
                print("MMMMMMMMMMMMMMMM")
                Util.translate(self.dest - self.frame.origin, v: self)
                isGround = w.isGround(p)
                if (isGround) {
                    print("Stop \(self.frame.origin)")
                    for b in self.blocks {
                        w.putBlock(b)
                    }
                }
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
    
    static func createO(tetrimino: Tetrimino) -> [Block]{
        var block: [Block] = []
        //let c = UIColor.yellowColor()
        let c = UIColor.blueColor()
        block.append(Block(o: p_00, c: c, t: tetrimino))
        block.append(Block(o: p_01, c: c, t: tetrimino))
        block.append(Block(o: p_10, c: c, t: tetrimino))
        block.append(Block(o: p_11, c: c, t: tetrimino))
        return block
    }
    
    func doubleTapped(sender: UITapGestureRecognizer) {
        print(self.game.height)
        print(self.game.width)
        print(self.frame.height)
        var lowest = CGFloat.max
        for var i = self.frame.origin.x; i < self.frame.origin.x + self.frame.size.width; i = Game.unit {
            let t = Game.getLowest(i)
            if t < lowest {
                lowest = t
            }
        }
        
        print("CCCCCCCCCC tapped \(lowest)")
        self.updateFromDiff(CGPointMake(0, lowest - self.frame.height - self.frame.origin.y))
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

