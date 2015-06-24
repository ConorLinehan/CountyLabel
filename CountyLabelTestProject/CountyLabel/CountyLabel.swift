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


class CountyLabel: UILabel {
    
    // Default duration of one second
    private var duration:NSTimeInterval = 1.0
    
    func CL_animateWithDuration(duration: NSTimeInterval?, from: Int, to:Int, completion: ((Bool) ->Void)?) {
        
        self.duration = duration!
        
        self.startValue = from
        self.endValue = to
        
        self.lastUpdateColor = self.textColor
        
        // add text color to start
        self.compleltionFunc = completion
        
        // grab start time
        self.startTime = CACurrentMediaTime()
        
        if(duration == 0){
            // No animation
            self.text = "\(endValue)"
        }
        
        // remove old Display Link
        if(displayLink != nil){
            displayLink.invalidate()
            displayLink = nil
        }
        
        self.totalTime = duration
        self.progress = 0
        self.percent = 0
        self.lastUpdateTime = NSDate.timeIntervalSinceReferenceDate()
        
        self.timer = NSTimer(timeInterval: (1/30.0), target: self, selector: Selector("tick:"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: UITrackingRunLoopMode)
        
        // create display link
        self.displayLink = CADisplayLink(target: self, selector: Selector("tick:"))
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    
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
    
    var startTime:CFTimeInterval!
    
    
    var endTimeStamp:NSTimeInterval!
    
    var timer:NSTimer!
    
    var displayLink:CADisplayLink!
    
    var compleltionFunc: ((Bool) -> Void)?
    
    func tick(link:CADisplayLink) ->Void{
        print("Entered \n")
        
        var dt = (link.timestamp - self.startTime) / self.duration
        
        if(dt >= 1.0){
            self.text =  "\(self.endValue)"
            link.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            return
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
        
        var updateVal = update(self.percent)
        
        return Double(self.startValue) + (updateVal * Double(self.endValue - self.startValue))
        
    }
    
    
    // Fixed error update from fixed values
    var currentColor:UIColor {
        
        lastUpdateColor = ColorInterpolate.interpolate(from:UIColor.blackColor(), to:UIColor.redColor(),fraction:CGFloat(self.percent))
        
        return lastUpdateColor
    }
    
    func update(t:Double) -> Double{
        return t
    }

}
