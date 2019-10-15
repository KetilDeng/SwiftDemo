//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/10.
//  Copyright © 2019 Ketil. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        BannerModel.getDatas { (result, error) in
//        }
        UserModel.getDatas()
        
//        TotalModel.getDatas()

    }


}

