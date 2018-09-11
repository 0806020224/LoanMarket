//
//  LoanMarketNetworking.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/25.
//  Copyright © 2018年 Young. All rights reserved.
//

import Alamofire
import SwiftyJSON



final class LoanMarketNetworking {
    
    class func acquireVerificationCode(withPhoneNumber number: String, completion: @escaping (Result<JSON>) -> Void) {
        let router = Router.acquireVerificationCode(scene: "login", phone: number)
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func login(withPhoneNumber number: String, verificationNumber: String, completion: @escaping (Result<JSON>) -> Void) {
        let router = Router.login(scene: "login", phone: number, verificationNumber: verificationNumber)
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func getSlideImages(completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.getSlideImages
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func getSubjects(completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.getSubjects
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func getTodayNewProducts(completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.getTodayNewProducts
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func getHotProducts(completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.hotProducts
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func subjectDetail(productID: String, completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.subjectDetail(productID: productID)
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
    
    class func getProductDetail(productID: String, completion: @escaping (Result<JSON>) -> Void) {
        
        let router = Router.getProductDetail(productID: productID)
        RequestHelper.request(router) { result in
            completion(result)
        }
    }
}






class RequestHelper {
    
    public class func request(_ router: Router, completion: @escaping (Result<JSON>) -> Void) {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        var httpLog = ""
        
        if let val = router.urlRequest?.httpMethod {
            httpLog += "\(val)"
        }
        
        if let val = router.urlRequest?.url?.absoluteString {
            httpLog += " \(val)"
        }
        
        if let val = router.urlRequest?.allHTTPHeaderFields {
            httpLog += "\nHeaders: \(val)"
        }
        
        if let data = router.urlRequest?.httpBody, let val = String(data: data, encoding: String.Encoding.utf8) {
            httpLog += "\nBody: \(val)"
        }
        print("\(httpLog)")
        Alamofire
            .request(router)
            .responseJSON { response in
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let result = Result.success(json)
                     completion(result)
                case .failure(let error):
                    let result = Result.failure(error as NSError) as Result<JSON>
                    completion(result)
                }
              
        }
    }
}
