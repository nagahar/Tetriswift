//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class ViewProxy: UIView {
    let tetrimino: Tetrimino!
    let world: World!
    var dest: CGPoint = CGPointZero
    
    init () {
        self.tetrimino = Tetrimino()
        self.world = World()
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.tetrimino = Tetrimino()
        self.world = World()
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        self.tetrimino = Tetrimino()
        self.world = World()
        super.init(frame: frame)
    }
    
    init (tetrimino: Tetrimino, w: World) {
        self.tetrimino = tetrimino
        self.world = w
        super.init(frame: CGRectMake(0, 0, tetrimino.Size.width, tetrimino.Size.height))
        for b in tetrimino.blocks {
            self.addSubview(b)
        }
        
        self.reset()
        
        //super.init(frame: CGRectMake(0, 0, tetrimino.Size.width + 10, tetrimino.Size.height + 10))
        //self.backgroundColor = UIColor.redColor()
    }
    
    deinit {
        dispose()
        self.removeFromSuperview()
    }
    
    func set(dest: CGPoint) {
        self.dest = dest
        //setDiff(dest - self.frame.origin)
    }
    
    func setDiff(diff: CGPoint) {
        self.dest = self.dest + diff
        
        //for b in tetrimino.blocks {
        //    b.dest = b.frame.origin + diff
        //}
    }
    
    func dispose() -> Tetrimino {
        let diff = self.frame.origin - CGPointMake(0, 0)
        for b in tetrimino.blocks {
            println("pre: \(b.frame.origin)")
            b.dest = b.frame.origin + diff
            b.moveTo(world)
            b.reset()
            println("post: \(b.frame.origin)")
            //b.removeFromSuperview()
            self.superview?.addSubview(b)
        }
        
        return self.tetrimino
    }
    
    func IsMoving() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo() -> Bool {
        if (world.IsMovable(CGRect(origin: dest, size: self.frame.size))) {
            world.translate(dest - self.frame.origin, view: self)
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        dest = self.frame.origin
        /*
        for b in tetrimino.blocks {
        b.reset()
        }
        */
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            let loc = touch.locationInView(self.superview)
            let x = world.normalize(loc.x, max: world.width - self.frame.width)
            let y = world.normalize(loc.y, max: world.height - self.frame.height)
            let pos = CGPointMake(x == -1 ? self.frame.origin.x: x , y == -1 ? self.frame.origin.y: y)
            set(pos)
        }
    }
}
