//
//  Extension.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/13.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}
