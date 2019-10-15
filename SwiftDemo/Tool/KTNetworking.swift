//
//  KTNetworking.swift
//  SwiftDemo
//
//  Created by Mac on 2019/10/10.
//  Copyright © 2019 Ketil. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

#if PRODUCTION
let baseURL = "https://hi.api.mitop.cc"
let socketURL = "wss://hi.api.mitop.cc:8001"
#else
let baseURL = "http://new.mitop.api.qidianjinfu.com/"
let socketURL = "ws://new.mitop.api.qidianjinfu.com:8001"
#endif

//let baseURL = "https://hi.api.mitop.cc"
//let socketURL = "wss://hi.api.mitop.cc:8001"

typealias KTResponseSuccess = (_ response:[AnyHashable: Any]?) -> Void
typealias KTResponseFail = (_ error: Error?) -> Void

class KTNetworking: NSObject {
    
    static let `default` = KTNetworking()
    private lazy var manager: SessionManager = {
        var config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        return SessionManager(configuration: config, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }()
    private let timeout:TimeInterval = 45
    private var httpHeader = ["Client":"ios"]
}

// MARK: - public method
extension KTNetworking {
    class public func getWithURL(url: String, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        self.default.requestWithURL(url:url, method: .get, params: params, success: success, error: error)
    }
    class public func postWithURL(url: String, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        self.default.requestWithURL(url:url, method: .post, params: params, success: success, error: error)
    }
}

// MARK: - private method
extension KTNetworking {
    
    private func requestWithURL(url: String, method: HTTPMethod, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        self.checkToken()
        let absoluteURL = self.absoluteURL(path: url)
        self.manager.request(absoluteURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: httpHeader).responseJSON { (response) in
            switch response.result {
            case .success:                
                if let value = response.result.value as? [AnyHashable: Any] {
                    print("==value:\(value)")
                    if value["code"] as? Int == 401 {//统一处理某些状态
                    }
                    success(value)
                }
            case .failure(let err):
                error(err)
            }
        }
    }
    
    private func checkToken() {
        if let tokenValue = UserModel.default.token {
            guard let headerToken = httpHeader["Authentication"], headerToken.count>0 else {
                httpHeader["Authentication"] = tokenValue
                return
            }
        }
    }
}

// MARK: - URL相关
extension KTNetworking {
    func absoluteURL(path: String?) -> String {
        if path == nil || path?.count == 0 {
            return baseURL
        }
        var absoluteUrl = baseURL
        if baseURL.hasSuffix("/") && (path?.hasPrefix("/"))! {
            absoluteUrl.removeLast()
        } else if !baseURL.hasSuffix("/") && !(path?.hasPrefix("/"))!  {
            absoluteUrl.append("/")
        }
        absoluteUrl.append(path!)
        return absoluteUrl
    }
}
