//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisViewFactory {
    func createView(parent : UIView?, color : UIColor?) -> TetrisView {
        var v = TetrisView(frame : CGRectMake(0, 0, TetrisView.UnitX * 2, TetrisView.UnitY * 2))
        v.backgroundColor = color
        parent?.addSubview(v)
        return v
    }
}
