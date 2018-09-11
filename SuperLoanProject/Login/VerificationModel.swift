//
//  VerificationModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class VerificationModel: BaseDataModel {
    
    var successMessage: String?

    class func verificationModel(withJson json: JSON) -> VerificationModel {
        let model = VerificationModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.data = json["data"].dictionaryValue
        model.successMessage = json["data"].dictionaryValue["message"]?.stringValue
        return model
    }
}
