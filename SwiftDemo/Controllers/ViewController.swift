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
        
       
        
        let params = ["user_name":"19978094343","pwd":"q123456","Client":"ios"]
        KTNetworking.postWithURL(url: "/login", params: params, success: { (result) in
            
        }) { (error) in
            
        }
    }


}

