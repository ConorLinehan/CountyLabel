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
    return t
}

func retriveRGBFromColor(color:UIColor) -> (CGFloat,CGFloat,CGFloat) {
    
    var fRed : CGFloat = 0
    var fGreen : CGFloat = 0
    var fBlue : CGFloat = 0
    
    color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: nil)
    
    return (fRed,fGreen,fBlue)
    
}

func interpolate(#start:Double, end:Double, stepNumber:Int, lastStepNumber:Int) -> Double{
    return 2.0
}

class CountyLabel: UILabel {
    
    
    var colorGradients = [UIColor.whiteColor(),UIColor.blueColor(),UIColor.redColor()]
    
    
    func CL_animateWithDuration(duration: NSTimeInterval, from: Int, to:Int, completion: ((Bool) ->Void)?) {
        
        self.startValue = from
        self.endValue = to
        
        self.lastUpdateColor = self.textColor
        
        // add text color to start
        colorGradients.insert(self.textColor, atIndex: 0)
        
        self.fractionUpdate = 1.0 / Double(colorGradients.count)

        
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
        self.percent = 0
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
    var percent:Double!
    var fractionUpdate:Double!
    
    var endTimeStamp:NSTimeInterval!
    
    var timer:NSTimer!
    
    func tick(timer:NSTimer) ->Void{
        print("Entered \n")
        
        // Grab now
        var now = NSDate.timeIntervalSinceReferenceDate()
        self.progress += (now - self.lastUpdateTime)
        
        self.percent = (self.progress / self.totalTime)
        
        self.lastUpdateTime = now
        
        
        if(self.progress >= self.totalTime){
            self.timer.invalidate()
            self.timer = nil
            self.progress = self.totalTime
        }
        
        
        self.updateValues()
        
    }
    
    func updateValues() {
        var formattedValue = Int(floor(self.currentValue))
        
        // run on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.text = "\(formattedValue)"
            self.textColor = self.currentColor
        });
    }
    
    
    var currentValue:Double {
        
        // For some fuzziness maybe??
        if(self.percent >= 1.1){
            return Double(self.endValue)
        }
        
        var updateVal = update(self.percent)
        
        return Double(self.startValue) + (updateVal * Double(self.endValue - self.startValue))
        
    }
    
    
    // Fixed error update from fixed values
    var currentColor:UIColor {
        
        println("fraction: \(self.percent)")
        
        lastUpdateColor = ColorInterpolate.interpolate(from:UIColor.blackColor(), to:UIColor.redColor(),fraction:CGFloat(self.percent))
        
        return lastUpdateColor
    }

}
