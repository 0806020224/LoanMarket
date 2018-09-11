//
//  LoginModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserManager {
    var user: UserModel?
    static let shareInstance = UserManager()
}


class UserModel {
    var userId: String?
    var phone: String?
    var token: String?
    class func usermodel(withJson json: JSON) -> UserModel {
        let model = UserModel()
        model.userId = json["user_id"].stringValue
        model.phone = json["phone"].stringValue
        model.token = json["token"].stringValue
        UserManager.shareInstance.user = model
        return model
    }
    
}

class LoginModel: BaseDataModel {
    var userModel: UserModel?
    class func loginModel(withJson json: JSON) -> LoginModel {
        let model = LoginModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.userModel = UserModel.usermodel(withJson: json["data"])
        return model
    }
}
