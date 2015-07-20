//
//  TetrisVC.swift
//  Tetriswift
//
//  Created by nagahara on 2015/07/19.
//  Copyright (c) 2015年 ___Takanori Nagahara___. All rights reserved.
//

import UIKit

class TetrisVC: UIViewController {
    
    let Duration : NSTimeInterval = 1 / 30
    let DX : CGFloat = 10.0
    let DY : CGFloat = 10.0
    //時間計測用の変数.
    var cnt : Float = 0
    
    //時間表示用のラベル.
    var myLabel : UILabel!
    
    var view1 : UIView!
    var view2 : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.StartGame()
    }
    
    func StartGame() {
        view1 = UIView(frame: CGRectMake(0, 0, 100, 100))
        view1.backgroundColor = .redColor()
        self.view.addSubview(view1)
        
        view2 = UIView(frame: CGRectMake(100, 0, 50, 200))
        view2.backgroundColor = .blueColor()
        self.view.addSubview(view2)
      
        //ラベルを作る.
        myLabel = UILabel(frame: CGRectMake(0, -400 ,200,50))
        myLabel.backgroundColor = UIColor.orangeColor()
        myLabel.layer.masksToBounds = true
        myLabel.layer.cornerRadius = 20.0
        myLabel.text = "Time:\(cnt)"
        myLabel.textColor = UIColor.whiteColor()
        myLabel.shadowColor = UIColor.grayColor()
        myLabel.textAlignment = NSTextAlignment.Center
        myLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        self.view.addSubview(myLabel)
        
        NSTimer.scheduledTimerWithTimeInterval(Duration, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
    }
    
    var mCnt : Int = 0
    var threashold : Float = 1 / 3
    //NSTimerIntervalで指定された秒数毎に呼び出されるメソッド.
    func onUpdate(timer : NSTimer){
        cnt += Float(Duration)
        //桁数を指定して文字列を作る.
        let str = "Time:".stringByAppendingFormat("%.1f",cnt)
        myLabel.text = str
        
        if (threashold < cnt) {
            cnt = 0
            mCnt++
            view1.transform = CGAffineTransformMakeTranslation(0, DY * CGFloat(mCnt));
            view2.transform = CGAffineTransformMakeTranslation(0, DY * CGFloat(mCnt));
            println("$$$$$$$$$")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}