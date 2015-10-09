//
//  Util.swift
//  Tetriswift
//
//  Created by nagahara on 2015/10/06.
//  Copyright © 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit


class Util {
    static func hasUpdated(p: CGPoint, v: UIView) -> Bool {
        return !CGPointEqualToPoint(v.frame.origin, p)
    }
    
    static func translate(p: CGPoint, v: UIView) {
        v.transform = CGAffineTransformTranslate(v.transform, p.x , p.y)
    }
}