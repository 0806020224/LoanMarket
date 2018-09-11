//
//  SubjectDetailModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON


class SubjectDetailData {
    var productId: String?
    var bannerUrl: String?
    var subjects: [HotProduct]?
    class func subjectDetailData(withJson json: JSON) -> SubjectDetailData {
        let model = SubjectDetailData()
        model.productId = json["topic_id"].stringValue
        model.bannerUrl = json["top_banner"].stringValue
        model.subjects = json["products"].arrayValue.map({HotProduct.hotProduct(withJson: $0)})
        return model
    }
}



class SubjectDetailModel: BaseDataModel {
    
    var subjectDetailData: SubjectDetailData?
    class func subjectDetailModel(withJson json: JSON) -> SubjectDetailModel {
        let model = SubjectDetailModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.subjectDetailData = SubjectDetailData.subjectDetailData(withJson: json["data"])
        return model
    }
}


