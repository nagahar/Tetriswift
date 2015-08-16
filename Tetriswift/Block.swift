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
    var isBound: Bool = false
    
    var worigin: (row: Int, column: Int) {
        get {
            return Game.convert(self.frame.origin)
        }
    }
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
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
    
    func isMoving() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo(w: World) {
        //let x = w.normalize(dest.x, max: w.width - self.frame.width)
        //let y = w.normalize(dest.y, max: w.height - self.frame.height)
        //let pos = CGPointMake(x == -1 ? self.frame.origin.x: x , y == -1 ? self.frame.origin.y: y)
        
        let converted = self.frame.origin + self.dest
        let s = CGRect(origin: converted, size: self.frame.size)
        let tuple = Game.convert(s)
        println(self.frame.origin)
        println(converted)
        if (w.isMovable(tuple)) {
            translate(self.dest - self.frame.origin)
            // TODO: 接地check
            self.isBound = false
        } else {
            self.isBound = true
        }
    }
    
    func limitCheck(row: Int, column: Int, height: Int, width: Int) -> Bool {
     /*
        if (World.blocks.count == maxRow) {
            println("Put Boundary**********")
            return false
        }

        if (World.blocks.count < maxRow || World.blocks.first!.count < maxCol) {
            println("Overflow**********")
            return false
        }
*/
        
        return true
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
        let diff = getDiff()
        self.center = diff + self.center
        self.reset()
        println("post: \(self.center)")
    }
    
    func setDestination(dest: CGPoint) {
        self.dest = normalize(dest)
        println("set dest \(self.dest)")
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            self.tetrimino!.update(touch.locationInView(self.superview))
        }
    }
    
    func addDoubleTap(selector: Selector) {
        let doubleTap = UITapGestureRecognizer(target: self, action: selector)
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
    }
    
    func doubleTapped(sender: UITapGestureRecognizer)
    {
        println("TTTTTTTTTTTT")
        println(tetrimino!.game.height)
        println(tetrimino!.game.width)
        println(self.frame.height)
        self.tetrimino!.update(CGPointMake(0, tetrimino!.game.height))
    }
    
    func normalize(p: CGFloat, max: CGFloat) -> CGFloat {
        let ret = Game.unit * floor(p / Game.unit)
        if (ret < 0) {
            return 0
        } else if (max < ret) {
            // tetriminoの形状から正しいmaxを返す
            return max
        } else {
            return ret
        }
    }
    
    private func normalize(loc: CGPoint) -> CGPoint {
        let x = normalize(loc.x, max: tetrimino!.game.width - self.frame.width)
        let y = normalize(loc.y, max: tetrimino!.game.height - self.frame.height)
        return CGPointMake(x, y)
    }
}
