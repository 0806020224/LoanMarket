//
//  File.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/25.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation
import Alamofire

public enum Router {
    case acquireVerificationCode(scene: String, phone: String)
    case login(scene: String, phone: String, verificationNumber: String)
    case getSlideImages
    case getSubjects
    case getTodayNewProducts
    case hotProducts
    case subjectDetail(productID: String)
    case getProductDetail(productID: String)
}


extension Router: URLRequestConvertible {
    
    fileprivate var method: Alamofire.HTTPMethod {
        switch self {
 
        case .acquireVerificationCode:           return .post
        case .login:                             return .post
        case .getSlideImages:                    return .get
        case .getSubjects:                       return .get
        case .getTodayNewProducts:               return .get
        case .hotProducts:                       return .get
        case .subjectDetail:                     return .get
        case .getProductDetail:                  return .get
        }
    }
    
    /// 路径
    fileprivate var path: String {
        switch self {
        case .acquireVerificationCode:          return "/app/api/v1/verify_codes"
        case .login:                            return "/app/api/v1/tokens"
        case .getSlideImages:                   return "/app/api/v1/slides"
        case .getSubjects:                      return "/app/api/v1/topics"
        case .getTodayNewProducts:              return "/app/api/v1/advertisements"
        case .hotProducts:                      return "/app/api/v1/products"
        case .subjectDetail(let productID):     return "/app/api/v1/topics/\(productID)"
        case .getProductDetail(let productID):  return "/app/api/v1/products/\(productID)"
        }
    }
    
    /// Header
    fileprivate var header: [String : String]? {
        let infoDictionary = Bundle.main.infoDictionary
        var tokenValue: String? = nil

        var headerParams = ["Accept": "application/json"]
        headerParams["os"] = "iOS " + UIDevice.current.systemVersion
        headerParams["version"] =  infoDictionary? ["CFBundleShortVersionString"] as? String
        headerParams["channel"] = "Appstore"
        return headerParams
    }
    
    /// 参数
    fileprivate var parameters: [String: Any]? {
        switch self {
    
        case .acquireVerificationCode(let scene, let phone):
            var params: [String: Any] = [:]
                params["scene"] = scene
                params["phone"] = phone
                return params
        case .login(let scene, let phone, let verificationNumber):
            var params: [String: Any] = [:]
            params["scene"] = scene
            params["phone"] = phone
            params["code"] = verificationNumber
            return params
        default:
            return nil
        }
    }
    
    /// 编码
    fileprivate var encoding: Alamofire.URLEncoding {
        switch self {
        default:    return Alamofire.URLEncoding.default
        }
    }
    
    /// Base URL
    fileprivate var BaseURL: URL? {
        switch self {
        default:                return DomainString.domain.toURL
        }
    }
    
    
    
    public func asURLRequest() throws -> URLRequest {
        guard let url = BaseURL else {
            throw NSError(domain: "URL is Bad", code: 0, userInfo: nil)
        }
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.httpMethod = method.rawValue
        if let header = header {
            for (key, value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        return try encoding.encode(urlRequest, with: parameters)
    }
}


extension String {
    var toURL: URL? {
        guard !self.isEmpty else { return nil }
        if let str = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            return URL(string: str)
        }
        return nil
    }
}

