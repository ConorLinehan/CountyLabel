//
//  CountyLabel.swift
//  CountyLabelTestProject
//
//  Created by Conor Linehan on 05/06/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

import UIKit

// A delay function
// From raywenderlich
func delay(#seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

func update(t:Double) -> Double{
    return pow(t, 3.0)
}

func randomColor() -> UIColor{
    
    var randomRed:CGFloat = CGFloat(drand48())
    var randomGreen:CGFloat = CGFloat(drand48())
    var randomBlue:CGFloat = CGFloat(drand48())
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}

func retriveRGBFromColor(color:UIColor) -> (CGFloat,CGFloat,CGFloat) {
    
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    
    color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: nil)
    
    return (fRed,fGreen,fBlue)
    
}

class CountyLabel: UILabel {
    
    

    
    func CL_animateWithDuration(duration: NSTimeInterval, from: Int, to:Int, completion: ((Bool) ->Void)?) {
        
        self.startValue = from
        self.endValue = to
        
        self.lastUpdateColor = self.textColor

        
        if(duration == 0){
            // No animation
            self.text = "\(endValue)"
        }
        
        // remove any old timer
        if(self.timer != nil){
            self.timer.invalidate()
            self.timer = nil
        }
        
        self.totalTime = duration
        self.progress = 0
        self.lastUpdateTime = NSDate.timeIntervalSinceReferenceDate()
        
        self.timer = NSTimer(timeInterval: (1/30.0), target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: UITrackingRunLoopMode)
    }
    
    
    private
    
    var startValue:Int = 0
    var endValue:Int = 50
    var easingRate:Double = 3.0
    var progress:Double = 0
    var lastUpdateTime:NSTimeInterval!
    var totalTime:NSTimeInterval!
    var lastUpdateColor:UIColor!
    var endColor = UIColor.redColor()
    
    var endTimeStamp:NSTimeInterval!
    
    var timer:NSTimer!
    
    func tick(timer:NSTimer) ->Void{
        print("Entered \n")
        
        // Grab now
        var now = NSDate.timeIntervalSinceReferenceDate()
        self.progress += (now - self.lastUpdateTime)
        self.lastUpdateTime = now
        
        if(self.progress >= self.totalTime){
            self.timer.invalidate()
            self.timer = nil
            self.progress = self.totalTime
        }
        
        println("progress: \(self.progress)")
        
        self.setTextValue(self.currentValue)
        
    }
    
    func setTextValue(value:Double) {
        var formattedValue = Int(floor(value))
        
        // run on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.text = "\(formattedValue)"
            self.textColor = self.currentColor
        });
    }
    
    
    var currentValue:Double {
        
        if(self.progress >= self.totalTime){
            return Double(self.endValue)
        }
        
        var percent = self.progress / self.totalTime
        var updateVal = update(percent)
        
        return Double(self.startValue) + (updateVal * Double(self.endValue - self.startValue))
        
    }
    
    var currentColor:UIColor {
        
        var (r,g,b) = retriveRGBFromColor(lastUpdateColor)
        
        var newRed = (1.0 - CGFloat(self.progress)) * r + CGFloat(self.progress) * CGFloat(255.00 / 255.00)
        var newGreen = (1.0 - CGFloat(self.progress)) * g + CGFloat(self.progress) * CGFloat(100.00 / 255.00)
        var newBlue = (1.0 - CGFloat(self.progress)) * b + CGFloat(self.progress) * CGFloat(111.00 / 255.00)
        
        
        println("new Red:\(newRed) Green: \(newGreen) Blue: \(newBlue)")
        
        lastUpdateColor = UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        
        return lastUpdateColor
    }

}
