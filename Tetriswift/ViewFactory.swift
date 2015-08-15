//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class ViewFactory {
    static var sharedInstance: ViewFactory {
        struct Static {
            static let instance: ViewFactory = ViewFactory()
        }
        
        return Static.instance
    }
    
    static func getInstance() -> ViewFactory {
        return ViewFactory.sharedInstance
    }
    
    func create(parent : UIView, w: World) -> ViewProxy {
        var t = Tetrimino(t: TetriminoType.O)
        let v = ViewProxy(tetrimino: t, w: w)
        parent.addSubview(v)
        return v
    }
    
}
