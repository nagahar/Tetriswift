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
    let Rate : Int = 30
    
    var cnt : Int = 0
    var level : Int = 1
    //var dest : CGPoint = CGPoint(x: 0, y: 0)
    //var prev : CGPoint = CGPoint(x: 0, y: 0)
    
    var factory : TetrisViewFactory!
    var view1 : TetrisView!
    var view2 : TetrisView!
    var world : World!
    
    @IBAction func Start(sender: AnyObject) {
        self.StartGame()
        StatButton.hidden = true
        
    }
    
    func StartGame() {
        factory = TetrisViewFactory()
        world = World(width: self.view.layer.frame.maxX, height: self.view.layer.frame.maxY)
        view1 = factory.createView(self.view, color: UIColor.redColor())
        NSTimer.scheduledTimerWithTimeInterval(Double(1.0 / Double(Rate)), target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    
    func IsTimeToMove(count : Int) -> Bool {
        if (count < Rate - (level - 1)) {
            return false
        }
        
        return true
    }
    
    
    func onUpdate(timer : NSTimer) {
        cnt += 1
        
        if (IsTimeToMove(cnt)) {
            println("origin: \(view1.layer.frame.origin)")
            println("dest0: \(view1.dest)")
            view1.dest.y += TetrisView.Unit.y
            cnt = 0
        }
        
        if (!CGPointEqualToPoint(view1.dest, view1.prev)) {
            println("origin: \(view1.frame.origin)")
            println("dest: \(view1.dest)")
            if (view1.moveTo(view1.dest, w: world)) {
                println("$$$$$$$$$ \(view1.layer.frame.origin)")
            } else {
                println("Stop")
                world.addBlock(view1.frame)
                view1 = factory.createView(self.view, color: UIColor.blueColor())
            }
            
            view1.reset()
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
