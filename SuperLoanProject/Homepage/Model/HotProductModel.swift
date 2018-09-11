//
//  HotProductModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class Condition {
    var content: String?
    class func condition(WithJson json: JSON) -> Condition{
        let condition = Condition()
        condition.content = json["content"].stringValue
        return condition
    }
}

class HotProduct {
    
    var productId: String?
    var maxCredit: String?
    var minCredit: String?
    var name: String?
    var logo: String?
    var description: String?
    var loanPeriod: String?
    var link: String?
    var auditTime: String?
    var downLoadCounts: String?
    var applyConditions: [Condition]?
    
    class func hotProduct(withJson json: JSON) -> HotProduct {
        let model = HotProduct()
        model.productId = json["product_id"].stringValue
        model.maxCredit = json["max_credit"].stringValue
        model.minCredit = json["min_credit"].stringValue
        model.name = json["name"].stringValue
        model.logo = json["logo"].stringValue
        model.description = json["description"].stringValue
        model.loanPeriod = json["loan_period"].stringValue
        model.link = json["link"].stringValue
        model.auditTime = json["audit_time"].stringValue
        model.downLoadCounts = json["download_count"].stringValue
        model.applyConditions = json["apply_conditions"].arrayValue.map({Condition.condition(WithJson: $0)})
        return model
    }
}

class HotProductModel: BaseDataModel {
    
    var products: [HotProduct]?
    class func todayNewProductModel(withJson json: JSON) -> HotProductModel {
        let model = HotProductModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.products = json["data"].arrayValue.map({HotProduct.hotProduct(withJson: $0)})
        return model
    }
}
