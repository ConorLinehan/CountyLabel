//
//  ColorHelpers.swift
//  CountyLabelTestProject
//
//  Created by Conor Linehan on 08/06/2015.
//  Copyright (c) 2015 Conor Linehan. All rights reserved.
//

import Foundation
import UIKit


class ColorInterpolate{

    class func interpolate(#from:UIColor,to:UIColor,fraction:CGFloat) -> UIColor {
            
            var fromHue:CGFloat = 0
            var fromSaturation:CGFloat = 0
            var fromBrightness:CGFloat = 0
            var fromAlpha:CGFloat = 0
            
            from.getHue(&fromHue, saturation: &fromSaturation, brightness: &fromBrightness, alpha: &fromAlpha)
            
            var toHue:CGFloat = 0
            var toSaturation:CGFloat = 0
            var toBrightness:CGFloat = 0
            var toAlpha:CGFloat = 0
            
            to.getHue(&toHue, saturation: &toSaturation, brightness: &toBrightness, alpha: &toAlpha)
            
            let deltaHue = toHue - fromHue
            let deltaSaturation = toSaturation - fromSaturation
            let deltaBrightness = toBrightness - fromBrightness
            let deltaAlpha = toAlpha - fromAlpha
            
            var resultHue:CGFloat = fromHue + fraction * deltaHue
            var resultSaturation:CGFloat = fromSaturation + fraction * deltaSaturation
            var resultBrightness:CGFloat = fromBrightness + fraction * deltaBrightness
            var resultAlpha:CGFloat = fromAlpha + fraction * deltaAlpha
            
            return UIColor(hue: resultHue, saturation: resultSaturation, brightness: resultBrightness, alpha: resultAlpha)
            
        }
}
