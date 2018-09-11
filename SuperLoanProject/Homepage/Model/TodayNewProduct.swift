//
//  TodayNewProduct.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class TodayNewProduct {
    
    var productId: String?
    var maxCredit: String?
    var name: String?
    var logo: String?
    class func todayNewProduct(withJson json: JSON) -> TodayNewProduct {
        let model = TodayNewProduct()
        model.productId = json["prouduct_id"].stringValue
        model.maxCredit = json["max_credit"].stringValue
        model.name = json["name"].stringValue
        model.logo = json["logo"].stringValue
        return model
    }
}

class TodayNewProductModel: BaseDataModel {
    
    var products: [TodayNewProduct]?
    class func todayNewProductModel(withJson json: JSON) -> TodayNewProductModel {
        let model = TodayNewProductModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.products = json["data"].arrayValue.map({TodayNewProduct.todayNewProduct(withJson: $0)})
        return model
    }
}
