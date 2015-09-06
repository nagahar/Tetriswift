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
    
    var origin_w: (row: Int, column: Int) {
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
    
    func hasUpdated() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo(w: World) {
        let point = Game.convert(self.dest)
        println("origin: \(self.frame.origin)")
        println("dest: \(self.dest)")
        if (w.isMovable(point)) {
            println("Move")
            translate(self.dest - self.frame.origin)
        }
        
        if (World.rows - 2 < point.row) {
            self.isBound = true
        } else {
            self.isBound = false
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
        //let diff = getDiff()
        //self.center = diff + self.center
        self.reset()
        //println("post: \(self.center)")
    }
    
    func setDestinationFromDiff(diff: CGPoint) {
        self.dest = self.frame.origin + diff
        println("set dest \(self.dest)")
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            self.update(touch.locationInView(self.superview))
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
        self.update(CGPointMake(0, tetrimino!.game.height))
    }
    
    func update(dest: CGPoint) {
        let p = Game.normalize(dest, current: self.tetrimino!.point)
        self.tetrimino!.update(p)
    }
    
    /*
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
        let p = Game.convert(loc)
        //let x = normalize(loc.x, max: tetrimino!.game.width - self.frame.width)
        //let y = normalize(loc.y, max: tetrimino!.game.height - self.frame.height)
        return CGPointMake(p.row * , y)
    }
*/
}
