//
//  Block.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Block: UIView {
    var dest: CGPoint = CGPointZero
    var tetrimino: Tetrimino?
    var isGround: Bool = false
    var isStopped: Bool = false
    var isTouchStarted: Bool = false
    var start: CGPoint = CGPointZero
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (o: CGPoint, c: UIColor, t: Tetrimino) {
        self.tetrimino = t
        super.init(frame: CGRectMake(o.x, o.y, Game.unit, Game.unit))
        self.backgroundColor = c
        self.reset()
        self.addDoubleTap("doubleTapped:")
    }
    
    deinit {
        dispose()
    }
    
    func dispose() {
        self.removeFromSuperview()
    }
    
    func hasUpdated() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo(w: World) {
        print("origin: \(self.frame.origin)")
        print("dest: \(self.dest)")
        let wdst = Game.convert(self.dest)
        self.isGround = true
        if (w.hasSpace(wdst)) {
            print("MMMMMMMMMMMMMMMM")
            self.translate(self.dest - self.frame.origin)
            self.isGround = w.isBound(wdst)
            if (self.isGround) {
                print("Stop \(self.frame.origin)")
                w.putBlock(self)
            }
        }
    }
    
    func translate(p: CGPoint) {
        self.transform = CGAffineTransformTranslate(self.transform, p.x , p.y)
    }
    
    func reset() {
        dest = self.frame.origin
    }
    
    func rightRotate() {
        
    }
    
    func leftRotate() {
        
    }
    
    func getDiff () -> CGPoint {
        return self.frame.origin - CGPointMake(0, 0)
    }
    
    func stop() {
        self.reset()
        self.isStopped = true
    }
    
    func setDestinationFromDiff(diff: CGPoint) {
        self.dest = Game.normalize(diff, b: self)
        print("set dest \(self.dest)")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isTouchStarted = true
        if let touch = touches.first {
            self.start = touch.locationInView(self.superview)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.update(touches, withEvent: event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.update(touches, withEvent: event)
        self.isTouchStarted = false
    }
    
    
    func update(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            print("###\(touches.count)")
            self.update(touch.locationInView(self.superview) - self.tetrimino!.blocks.first!.frame.origin)
        }
    }
    
    func addDoubleTap(selector: Selector) {
        let doubleTap = UITapGestureRecognizer(target: self, action: selector)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func doubleTapped(sender: UITapGestureRecognizer) {
        print(tetrimino!.game.height)
        print(tetrimino!.game.width)
        print(self.frame.height)
        var topy = (b: tetrimino!.blocks.first!, y: CGFloat.max)
        let s = tetrimino!.sortDescBlocks()
        for b in s {
            let t = Game.getTopY(b.frame.origin.x)
            if t < topy.y {
                topy.y = t
                topy.b = b
            }
        }
        
        print("CCCCCCCCCC tapped \(topy.y): \(topy.b.frame.origin.y)")
        self.update(CGPointMake(0, topy.y - topy.b.frame.height - topy.b.frame.origin.y))
    }
    
    func update(diff: CGPoint) {
        print("$$$$$$$$$ \(diff)")
        //let p = Game.normalize(diff)
        self.tetrimino!.updateFromDiff(diff)
    }
}
