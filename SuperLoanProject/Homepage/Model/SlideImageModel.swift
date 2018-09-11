//
//  SlideImageModel.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import SwiftyJSON

class SlideImage {
    var productId: String?
    var name: String?
    var imageUrl: String?
    class func slideImageMode(withJson json: JSON) -> SlideImage {
        let model = SlideImage()
        model.productId = json["prouduct_id"].stringValue
        model.name = json["name"].stringValue
        model.imageUrl = json["slide_banner"].stringValue
        return model
    }
}

class SlideImageModel: BaseDataModel {
    var images: [SlideImage]?
    
    class func slideImageModel(withJson json: JSON) -> SlideImageModel {
        let model = SlideImageModel()
        model.errorCode = json["error_code"].stringValue
        model.errorType = json["error_type"].stringValue
        model.errorMessage = json["error_message"].stringValue
        model.images = json["data"].arrayValue.map({SlideImage.slideImageMode(withJson: $0)})
        return model
    }
}
