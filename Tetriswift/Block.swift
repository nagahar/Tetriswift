//
//  Block.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Block: TetrisView {
    var tetrimino: Tetrimino?
    var isGround: Bool = false
    
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
        super.init(frame: CGRectMake(o.x, o.y, Game.funit, Game.funit))
        self.tetrimino = t
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
    
    func moveTo(w: World) {
        super.moveTo(w, c:{() -> Bool in
            print("BBBBBBBB")
            Util.translate(self.dest - self.frame.origin, v: self)
            return false
        })
    }
    
    func locationInView(parent: UIView) -> CGPoint {
        return self.frame.origin + parent.frame.origin
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("@@@@@@@@@")
    }
    
    func reset() {
        dest = self.frame.origin
    }
    
    func getDiff () -> CGPoint {
        return self.frame.origin - CGPointMake(0, 0)
    }
}
