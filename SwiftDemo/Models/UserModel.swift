//
//  UserModel.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/15.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation

class UserModel: BaseModel {
    
    var user_id:String?
    var phone:String?
    var email:String?
    var invite_code:String?
    var isset_paypwd:String?
    var token:String?
    var wstoken:String?
    var verity_type:String?
    var username:String?
    var is_realname:String?
    var loginAccount:String?
    var invite_Url:String?
    var stat_id:String?
    var isMail:Bool?
    var realname:String?
    
    static var `default` = UserModel()

    class func getDatas() {
        let params = ["user_name":"19978094343","pwd":"q123456","Client":"ios"]
        KTNetworking.postWithURL(url: "/login", params: params, success: { (response) in

            let responseValue = response as! [String:Any]
            if responseValue["code"] as? Int == 200 {
                let datas:[String:Any] = responseValue["data"] as! [String:Any]
                if let object = UserModel.deserialize(from: datas) {
                    self.default = object
                    
                    TotalModel.getDatas()
                }
            }
            
        }) { (error) in
            
        }
    }
}
