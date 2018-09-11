//
//  ProductDetailModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProductDetailModel: BaseDataModel {
    
    var product: HotProduct?
    class func productDetailModel(withJson json: JSON) -> ProductDetailModel {
        let model = ProductDetailModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.product = HotProduct.hotProduct(withJson: json["data"])
        return model
    }
}
