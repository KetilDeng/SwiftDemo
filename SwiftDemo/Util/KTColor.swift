//
//  KTColor.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/16.
//  Copyright © 2019 Ketil. All rights reserved.
//

import UIKit
extension UIColor {

    internal class func RGB(red:CGFloat, green:CGFloat, blue:CGFloat) -> UIColor {
        return self.RGBA(red: red, green: green, blue: blue, aplha: 1)
    }
    
    internal class func RGBA(red:CGFloat, green:CGFloat, blue:CGFloat, aplha:CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: aplha)
    }
    
    internal class func hex(_ hexString: String) -> UIColor{
        return self.hexColor(hexString, alpha: 1)
    }
    
    internal class func hexA(_ hexString: String ,alpha:CGFloat) -> UIColor{
        return self.hexColor(hexString, alpha: alpha)
    }
    
    internal class func hexColor(_ hexString:String ,alpha:CGFloat) -> UIColor{
        var cstr = hexString.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines).uppercased() as NSString;
        if(cstr.length < 6){
            return UIColor.clear;
        }
        if(cstr.hasPrefix("0X") || cstr.hasPrefix("0x")){
            cstr = cstr.substring(from: 2) as NSString
        }
        if(cstr.hasPrefix("#")){
            cstr = cstr.substring(from: 1) as NSString
        }
        if(cstr.length != 6){
            return UIColor.clear;
        }
        var range = NSRange.init()
        range.location = 0
        range.length = 2
        //r
        let rStr = cstr.substring(with: range);
        //g
        range.location = 2;
        let gStr = cstr.substring(with: range)
        //b
        range.location = 4;
        let bStr = cstr.substring(with: range)
        var r :UInt32 = 0x0;
        var g :UInt32 = 0x0;
        var b :UInt32 = 0x0;
        Scanner.init(string: rStr).scanHexInt32(&r);
        Scanner.init(string: gStr).scanHexInt32(&g);
        Scanner.init(string: bStr).scanHexInt32(&b);
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha);
    }
}
