//
//  SubjectModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class Subject {
    
    var productId: String?
    var imageUrl: String?
    class func subjectMode(withJson json: JSON) -> Subject {
        let model = Subject()
        model.productId = json["topic_id"].stringValue
        model.imageUrl = json["homepage_banner"].stringValue
        return model
    }
}

class SubjectModel: BaseDataModel {
    
    var subjects: [Subject]?
    class func subjectModel(withJson json: JSON) -> SubjectModel {
        let model = SubjectModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.subjects = json["data"].arrayValue.map({Subject.subjectMode(withJson: $0)})
        return model
    }
}
