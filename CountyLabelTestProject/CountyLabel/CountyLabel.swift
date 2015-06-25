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
    
    
    
    
    func CL_animateWithDuration(duration: NSTimeInterval, to:Int, completion: ((Bool) ->Void)?) {
        
        if(duration == 0){
            self.text = "\(to)"
            completion?(true)
            return
        }
        
        self.duration = duration
        
        self.endValue = to
        
        // Grab start value from label
        if let val = self.text?.toInt(){
            self.startValue = val
        }
        
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
            startValue = 0
        }
        
        
        self.totalTime = duration
        self.progress = 0
        self.percent = 0
        self.lastUpdateTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // create display link
        self.displayLink = CADisplayLink(target: self, selector: Selector("tick:"))
        self.displayLink.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    private var startValue:Int = 0
    private var endValue:Int = 50
    private var easingRate:Double = 3.0
    private var progress:Double = 0
    private var lastUpdateTime:NSTimeInterval!
    private var totalTime:NSTimeInterval!
    private var endColor = UIColor.redColor()
    private var percent:Double!
    private var fractionUpdate:Double!
    
    private var startTime:CFTimeInterval!
    
    private var displayLink:CADisplayLink!
    
    private var compleltionFunc: ((Bool) -> Void)?
    
    private func tick(link:CADisplayLink) ->Void{
        
        var dt = (link.timestamp - self.startTime) / self.duration
        
        if(dt >= 1.0){
            self.text =  "\(self.endValue)"
            link.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            self.compleltionFunc?(true)
            self.startValue = 0 // TODO handle this better
            return
        }
        
        self.percent = dt
        
        
        self.updateValues()
        
    }
    
    private func updateValues() {
        var formattedValue = Int(floor(self.currentValue))
        
        // run on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.text = "\(formattedValue)"
            self.textColor = ColorInterpolate.interpolate(from: UIColor.blackColor(), to: UIColor.redColor(), fraction: CGFloat(self.percent))
        });
    }
    
    
    private var currentValue:Double {
        
        var updateVal = update(self.percent)
        
        return Double(self.startValue) + (updateVal * Double(self.endValue - self.startValue))
        
    }
    
    private func update(t:Double) -> Double{
        return t
    }

}
