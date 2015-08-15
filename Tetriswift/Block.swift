//
//  Block.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Block: UIView  {
    var dest: CGPoint = CGPointZero
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (o: CGPoint, c: UIColor) {
        super.init(frame: CGRectMake(o.x, o.y, World.unit, World.unit))
        self.backgroundColor = c
    }
 
    deinit {
        dispose()
    }
    
    func dispose() {
       self.removeFromSuperview()
    }
    
    func IsMoving() -> Bool {
        return !CGPointEqualToPoint(dest, self.frame.origin)
    }
    
    func moveTo(w: World) -> Bool {
        let x = w.normalize(dest.x, max: w.width - self.frame.width)
        let y = w.normalize(dest.y, max: w.height - self.frame.height)
        let pos = CGPointMake(x == -1 ? self.frame.origin.x: x , y == -1 ? self.frame.origin.y: y)
        if (w.IsMovable(CGRect(origin: pos, size: self.frame.size))) {
            w.translate(pos - self.frame.origin, view: self)
            return 0 <= y
        } else {
            return false
        }
    }
   
   
    func reset() {
        dest = self.frame.origin
    }
}
