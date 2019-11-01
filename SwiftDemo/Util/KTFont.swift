//
//  KTFont.swift
//  SwiftDemo
//
//  Created by Mac on 2019/11/1.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
import UIKit

let scale: CGFloat = UIScreen.main.bounds.size.width/375.0

extension UIFont {

    internal class func font(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size * scale)
    }
    
    internal class func fontBold(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size * scale)
    }
    
    internal class func fontItalic(_ size: CGFloat) -> UIFont {
        return UIFont.italicSystemFont(ofSize: size * scale)
    }
    
    internal class func font(_ size: CGFloat, weight: CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont.systemFont(ofSize: size * scale, weight: UIFont.Weight.init(rawValue: weight))
        } else {
            return UIFont.systemFont(ofSize: size * scale)
        }
    }
    
    internal class func font(_ name: String, size: CGFloat) -> UIFont {
        if let font = UIFont.init(name: name, size: size * scale) {
            return font
        }
        return UIFont.systemFont(ofSize: size * scale)
    }
}
