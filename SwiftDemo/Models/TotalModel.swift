//
//  TotalModel.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation

class TotalModel: BaseModel {
    var btc:String?
    var cny:String?
    
    class func getDatas() {
        KTNetworking.getWithURL(url: "asset/total", params: nil, success: { (response) in

            
        }) { (error) in
            
        }
    }
}
