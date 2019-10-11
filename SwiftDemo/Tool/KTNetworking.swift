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

typealias KTResponseSuccess = (_ response:AnyObject) -> Void
typealias KTResponseFail = (_ error: AnyObject) -> Void
typealias KTNetworkingStatus = (_ KTNetworkStatus: Int32) -> Void

@objc enum KTNetworkStatus: Int32 {
    case unknown = -1//未知
    case notReachable = 0//无连接
    case wwan = 1//移动网络
    case wifi = 2//WiFi
}

class KTNetworking: NSObject {
    
    static let `default` = KTNetworking()
    private lazy var manager: SessionManager = {
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = timeout
        config.httpAdditionalHeaders = httpHeader
        return SessionManager(configuration: config, delegate: SessionDelegate(), serverTrustPolicyManager: nil)
    }()
    
    private let timeout:TimeInterval = 30
    public var httpHeader: [String:String]? {
//        didSet {
//
//        }
        return ["token":"tokenvalue"]
    }
    
    private var ktNetworkstatus:KTNetworkStatus = KTNetworkStatus.wifi
    
    class public func getWithURL(url: String, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        self.requestWithURL(url:url, method: .get, params: params, success: success, error: error)
    }
    
    class public func postWithURL(url: String, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        self.requestWithURL(url:url, method: .post, params: params, success: success, error: error)
    }
    
    class private func requestWithURL(url: String, method: HTTPMethod, params: [String: Any]?, success: @escaping KTResponseSuccess, error: @escaping KTResponseFail) {
        let absoluteURL = self.default.absoluteURL(path: url)
        self.default.manager.request(absoluteURL, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {

            case .success:
                
                print("==\(response)")
                
                if let value = response.result.value as? [String: Any] {
                    
                    print("==\(value)")

                    if value["code"] as? Int == 401 {//统一处理某些状态
                        error("被迫下线" as AnyObject)
                        return
                    }
                    success(value as AnyObject)
                }
                
            case .failure(let err):
                error(err as AnyObject)
                debugPrint(error)
            }
        }
    }
}

// MARK:网络监听
extension KTNetworking {
    
}

// MARK:URL相关
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
