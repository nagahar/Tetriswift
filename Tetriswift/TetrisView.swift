//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisView: UIView {
    static let UnitX : CGFloat = 50.0
    static let UnitY : CGFloat = 50.0
    
    func moveTo(x : CGFloat, y : CGFloat, w : World) -> Bool {
        if (w.IsMovable(x, y: y)) {
            var dy : CGFloat = 0.0
            if (0 <= y && y + TetrisView.UnitY <= w.height){
                dy = y - self.layer.frame.origin.y
                dy = dy < 0 ? 0 : dy
            }
            
            var dx : CGFloat = 0.0
            if (0 <= x && x + TetrisView.UnitX <= w.width) {
                dx = x - self.layer.frame.origin.x
            }
            
            self.translate(dx, dy: dy)
            return true
        }else {
            return false
        }
    }
    
    private func translate(dx: CGFloat, dy : CGFloat) {
        self.transform = CGAffineTransformTranslate(self.transform, normalize(dx, baseVal: TetrisView.UnitX), normalize(dy, baseVal: TetrisView.UnitY));
        println(normalize(dx, baseVal: TetrisView.UnitX))
        println(normalize(dy, baseVal: TetrisView.UnitY))
    }
    
    func normalize(val : CGFloat, baseVal : CGFloat) -> CGFloat {
        return baseVal * floor(val / baseVal)
        
    }
}
