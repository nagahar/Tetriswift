//
//  Block.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/15.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class Block: UIView {
    var tetrimino: Tetrimino?
    
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
        // to avoid capturing event on this view
        self.userInteractionEnabled = false
    }
    
    deinit {
        dispose()
    }
    
    func dispose() {
        self.removeFromSuperview()
    }
    
    func moveTo(w: World, dest: CGPoint) {
        Util.moveTo(self, dest: dest, c:{() -> Bool in
            print("BBBBBBBB")
            return true
        })
    }
    
    func locationInView(parent: UIView) -> CGPoint {
        return self.frame.origin + parent.frame.origin
    }
}
