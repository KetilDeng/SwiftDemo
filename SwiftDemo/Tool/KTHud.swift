//
//  KTHud.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
import UIKit
class KTHud: UIResponder {
    
    static let `default` = KTHud()
    
    class func show(){
//        var imagesArray = Array<UIImage>()
//        for i in 1...7 {
//            imagesArray.append(UIImage(named: "loading\(i)")!)
//        }
//        self.default.pleaseWaitWithImages(imagesArray, timeInterval: 0)
        self.default.pleaseWait()
    }
    
    class func hidden() {
        self.default.clearAllNotice()
    }
    
    class func showInfo(_ info: String) {
        SwiftNotice.mainColor = UIColor.hex("13072D")
        SwiftNotice.textColor = UIColor.hex("FFE795")
        SwiftNotice.textFont = UIFont.systemFont(ofSize: 14)
        self.default.noticeOnlyText(info)
    }
    
    class func showSuccess(_ info: String) {
        self.default.noticeSuccess(info)
    }
    
    class func showError(_ info: String) {
        self.default.noticeError(info)
    }
    
    class func showinfoffff(_ info: String) {
        self.default.noticeInfo(info)
    }
    
    class func showTopInfo(_ info: String) {
        self.default.noticeTop(info)
    }
}
