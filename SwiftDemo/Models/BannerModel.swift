//
//  BannerModel.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/11.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation

class BannerModel: BaseModel {
    var img:String?
    var url:String?
    
    func getDatas(models: @escaping (_ model:[BannerModel]) -> Void) {
        
        KTNetworking.getWithURL(url: "/index/banner/", params: nil, success: { (result) in
            
            let value = result as! [String: Any]
            let datas:[AnyObject] = value["data"] as! [AnyObject]
            if let bannerModels = [BannerModel].deserialize(from: datas) {
                bannerModels.forEach({ (bannerModel) in
                    // ...
                })
                models(bannerModels as! [BannerModel])
            }
            
        }) { (error) in
            
        }
    }
    
   
}
