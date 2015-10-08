//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/10/08.
//  Copyright © 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisView: UIView {
    var dest: CGPoint = CGPointZero
    
    func moveTo(w: World, c: () -> Bool) -> Bool {
        if (Util.hasUpdated(self.dest, v: self)) {
            print("move from \(self.frame.origin)")
            print("dest: \(self.dest)")
            return c()
        }
        
        return false
    }
    
    func updateFromDiff(diff: CGPoint) {
        self.dest = Game.normalize(diff, v: self)
    }
    
    func convert(b: Block) -> (Int, Int) {
        return Game.convert(b.locationInView(self))
    }
}
