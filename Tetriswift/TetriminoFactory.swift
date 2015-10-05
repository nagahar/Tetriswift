//
//  TetrisView.swift
//  Tetriswift
//
//  Created by nagahara on 2015/08/01.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetriminoFactory {
    let game: Game
    
    init (game: Game) {
        self.game = game
    }
    
    func create(parent : UIView) -> Tetrimino {
        let t = Tetrimino(type: TetriminoType.O, game: self.game)
        parent.addSubview(t)
        return t
    }
}
