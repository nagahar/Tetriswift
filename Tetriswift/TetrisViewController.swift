//
//  TetrisViewController.swift
//  Tetriswift
//
//  Created by nagahara on 2015/07/25.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisViewController: UIViewController {
    
    @IBOutlet weak var StatButton: UIButton!
    let Rate: Int = 30
    
    var timeCount: Int = 0
    var level: Int = 1
    
    var factory: ViewFactory = ViewFactory.getInstance()
    var proxy: ViewProxy!
    var world: World!
    
    @IBAction func Start(sender: AnyObject) {
        self.StartGame()
        StatButton.hidden = true
        
    }
    
    func StartGame() {
        world = World(width: self.view.layer.frame.maxX, height: self.view.layer.frame.maxY)
        proxy = factory.create(self.view, w: world)
        NSTimer.scheduledTimerWithTimeInterval(Double(1.0 / Double(Rate)), target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    
    func IsTimeToMove(count: Int) -> Bool {
        if (count < Rate - (level - 1)) {
            return false
        }
        
        return true
    }
    
    func onUpdate(timer: NSTimer) {
        timeCount += 1
        
        if (IsTimeToMove(timeCount)) {
            proxy.setDiff(CGPointMake(0, World.unit))
            timeCount = 0
        }
        
        // 全て動かす
        if (proxy.IsMoving()) {
            if (proxy.moveTo()) {
                println("$$$$$$$$$ \(proxy.layer.frame.origin)")
            } else {
                println("Stop")
                let t = proxy.dispose()
                world.putTetrimino(t)
                world.removeLine()
                proxy = factory.create(self.view, w: world)
            }
            
            proxy.reset()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
