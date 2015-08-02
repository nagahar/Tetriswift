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
    var duration : NSTimeInterval = 0.0
    
    var cnt : Float = 0
    var level : Int = 0
    
    var dx : CGFloat = 0
    var dy : CGFloat = 0
    
    var factory : TetrisViewFactory!
    var view1 : TetrisView!
    var view2 : TetrisView!
    var world : World!
    
    @IBAction func Start(sender: AnyObject) {
        self.StartGame()
        StatButton.hidden = true
        
    }
    
    func StartGame() {
        duration = (1.0 / Double(Rate))
        factory = TetrisViewFactory()
        world = World(width: self.view.layer.frame.maxX, height: self.view.layer.frame.maxY)
        view1 = factory.createView(self.view, color: UIColor.redColor())
        NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    
    func CurrentThreshold() -> Float {
        return Float(duration) * Float(-10 * level + 40)
    }
    
    func onUpdate(timer : NSTimer){
        cnt += Float(duration)
        if (CurrentThreshold() < cnt) {
            cnt = 0
            if (dy == 0) {
                dy = view1.layer.frame.origin.y
            }
            
            dy += TetrisView.UnitY
        }
        
        if (dx > 0 || dy > 0) {
            if (dx == 0) {
                dx = view1.layer.frame.origin.x
            }
            
            if (dy == 0) {
                dy = view1.layer.frame.origin.y
            }
            
            if (view1.moveTo(dx, y: dy, w: world)) {
                println("$$$$$$$$$")
            } else {
                println("Stop")
                view1 = factory.createView(self.view, color: UIColor.blueColor())
            }
            
            dx = 0
            dy = 0
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            let location = touch.locationInView(self.view)
            println("!!!!!!!!")
            dx = location.x
            dy = location.y
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch : AnyObject in touches {
            let location = touch.locationInView(self.view)
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}
