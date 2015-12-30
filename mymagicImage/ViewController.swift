//
//  ViewController.swift
//  mymagicImage
//
//  Created by  yanglc on 15/12/30.
//  Copyright © 2015年  yanglc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myimage0: MyImage!
    @IBOutlet weak var myimage1: MyImage!
    
    var exchangeImage0:UIImageView!
    var exchangeImage1:UIImageView!
    
    
    var panges0:UIPanGestureRecognizer!
    var panges1:UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        myimage1.userInteractionEnabled = true;
        myimage0.userInteractionEnabled = true;
        panges0 = UIPanGestureRecognizer(target: self, action: "dohandle1:")
        
        
        panges1 = UIPanGestureRecognizer(target: self, action: "dohandle1:")
        
        myimage0.addGestureRecognizer(panges0)
        myimage1.addGestureRecognizer(panges1)
        
        resetImageToHide(myimage0)
        
    }
    
    
    func resetImageToHide(iii:UIImageView){
        
        iii.frame  = self.view.frame;
        iii.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
        
    }
    
    
    func dohandle1(ppp:UIPanGestureRecognizer){
        
        if(ppp.view == myimage1){
            exchangeImage0 = myimage0;
            exchangeImage1 = myimage1;
            
        }else{
            exchangeImage0 = myimage1;
            exchangeImage1 = myimage0;
            
        }
        
        
        
        var point =  ppp.translationInView(self.view)
        
        
        var w = self.view.bounds.width / 2;
        
        exchangeImage1.center = CGPointMake(w, exchangeImage1.center.y + point.y)
        
        
        var kuaiman = ppp.velocityInView(self.view);
        
        //print(kuaiman)
        
        
        ppp.setTranslation(CGPointMake(0, 0), inView: self.view);
        
        
        //开始处理image2
        
        var degree  = CGFloat(abs(exchangeImage1.frame.origin.y)) / exchangeImage1.frame.height;
        
        var toscale = 0.8 + 0.2 * degree;
        
        self.exchangeImage0.transform = CGAffineTransformMakeScale(toscale, toscale);
        
        
        
        
        
        
        //拖动结束
        if(ppp.state == .Ended){
            
            var num1 = exchangeImage1.frame.origin.y;
            var num2 = abs(exchangeImage1.frame.origin.y);
            
            if(num2 > 200){
                
                
                var duration = 2.0 * kuaiman.y / 2000.0;
                
                
                duration  = 0.5;
                
                UIView.animateWithDuration(Double(duration), animations: { () -> Void in
                    
                    if(num1 > 0){
                        self.exchangeImage1.frame =  CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height);
                        
                        
                    }else{
                        self.exchangeImage1.frame =  CGRect(x: 0, y: -self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height);
                    }
                    
                    
                    self.exchangeImage0.transform = CGAffineTransformMakeScale(1, 1);
                    
                    }, completion: { (bbb) -> Void in
                        
                        
                        self.view.bringSubviewToFront(self.exchangeImage0)
                        self.resetImageToHide(self.exchangeImage1)
                        
                        
                })
                
            }else{
                // var duration = 2.0 * kuaiman.y / 2000.0;
                
                var duration  = 0.5;
                UIView.animateWithDuration(Double(duration), animations: { () -> Void in
                    
                    self.exchangeImage1.frame = self.view.frame
                    
                    self.exchangeImage0.transform = CGAffineTransformMakeScale(0.8, 0.8);
                    
            
                })
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

