//
//  BannerModel.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
typealias BannerModelResult = (_ model:[BannerModel]?, _ error:String?) -> Void

class BannerModel: BaseModel {
    var img:String?
    var url:String?
    
    class public func getDatas(result: @escaping BannerModelResult) {

        KTNetworking.getWithURL(url: "index/banner", params: nil, success: { (response) in

            if let value = response {
                if value["code"] as? Int == 200 {
                    let datas:[AnyObject] = value["data"] as! [AnyObject]
                    let bannerModels = [BannerModel].deserialize(from: datas)
                    result(bannerModels as? [BannerModel], nil)
                } else {
                    let msg:String? = value["msg"] as? String
                    result(nil, msg)
                }
            } else {
                result(nil, "数据为空")
            }
            
        }) { (error) in
            result(nil, "网络异常")
        }
    }
}
