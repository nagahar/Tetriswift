//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisView: UIView {
    static let Unit : CGPoint = CGPoint(x: 50.0, y: 50.0)
    var dest : CGPoint = CGPoint(x: 0, y: 0)
    var prev : CGPoint = CGPoint(x: 0, y: 0)
    
    func moveTo(p : CGPoint, w : World) -> Bool {
        let x = normalize(p.x, unit: TetrisView.Unit.x, max: w.width - self.frame.width)
        let y = normalize(p.y, unit: TetrisView.Unit.y, max: w.height - self.frame.height)
        let pos = CGPoint(x: x == -1 ? self.frame.origin.x : x , y: y == -1 ? self.frame.origin.y : y)
        if (w.IsMovable(CGRect(origin: pos, size: self.frame.size))) {
            self.translate(pos - self.frame.origin)
            return 0 <= y
        } else {
            return false
        }
    }
    
    private func translate(p: CGPoint) {
        self.transform = CGAffineTransformTranslate(self.transform, p.x , p.y)
    }
    
    func normalize(p: CGFloat, unit: CGFloat, max: CGFloat) -> CGFloat {
        let ret = unit * floor(p / unit)
        if (ret < 0) {
            return 0
        } else if (max < ret) {
            return -1
        } else {
            return ret
        }
    }
    
    func reset() {
        dest = self.frame.origin
        println("origin: \(self.frame.origin)")
        println("dest2: \(self.dest)")
        prev = self.frame.origin
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            dest = touch.locationInView(self.superview)
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            let location = touch.locationInView(self.superview)
        }
    }
}
