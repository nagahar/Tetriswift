//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class ViewProxy: UIView {
    var tetrimino: Tetrimino?
    var game: Game?
    var dest: CGPoint = CGPointZero
    
    init () {
        super.init(frame: CGRectZero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init (tetrimino: Tetrimino, g: Game) {
        self.tetrimino = tetrimino
        self.game = g
        super.init(frame: CGRectMake(0, 0, tetrimino.size.width, tetrimino.size.height))
        for b in tetrimino.blocks {
            self.addSubview(b)
        }
        
        self.reset()
    }
    
    deinit {
        dispose()
        self.removeFromSuperview()
    }
    
   
    
    func dispose() -> Tetrimino {
        return self.tetrimino!
    }
   
   
   
    func reset() {
        dest = self.frame.origin
    }
  
}
