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
        // to capture event on super view
        self.userInteractionEnabled = false
    }
    
    deinit {
        dispose()
    }
    
    func dispose() {
        self.removeFromSuperview()
    }
    
    /*
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
*/
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("@@@@@@@@@")
    }
    
    func reset() {
        dest = self.frame.origin
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
   
  
}
