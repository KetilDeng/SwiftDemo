//
//  KTMacro.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/16.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
import UIKit

let Screen_Height = UIScreen.main.bounds.size.height
let Screen_Width = UIScreen.main.bounds.size.width
let SystemVersion = Int(UIDevice.current.systemVersion)
let Scale_Width:CGFloat = Screen_Width/375.0
let Scale_Height:CGFloat = Screen_Height/667.0
let NavigationBar_Height = 44
let StatusBar_Height = (IS_FullScreen() ? 44 : 20)
let NavigationStatusBar_Height = (IS_FullScreen() ? 88 : 64)
let TabBar_Height = (IS_FullScreen() ? 83 : 49)
let SafeArea_BottomHeight = (IS_FullScreen() ? 34 : 0)
func IS_FullScreen() -> Bool {
    guard #available(iOS 11.0, *) else {
        return false
    }
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}
