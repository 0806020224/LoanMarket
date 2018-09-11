//
//  ConfigureFile.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/25.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation

struct NotificationName {
     public static let LoadMoreNotification = "LoadMoreNotification"
}


struct UMConfigEventId {
    public static let BannerAdvertisement = "BannerAdvertisement"
    public static let HomePageProductsList = "HomePageProductsList"
    public static let HomePagePromotion = "HomePagePromotion"
    public static let HomePageSubject = "HomePageSubject"
    public static let HomePageVisit = "HomePageVisit"
    public static let MarketVisit = "MarketVisit"
    public static let ProductDetailPageVisit = "ProductDetailPageVisit"
}

struct HTMLURLString {
    public static let aboutUsString = "http://h5.mslqtech.com/app-h5/aboutus.html"
    public static let contractString = "http://h5.mslqtech.com/app-h5/bbsregisteragreement.html"
}

//本地：https://victor.xpayai.com
//测试：https://api2-dev.mslqtech.com
//线上：https://api2.mslqtech.com
struct DomainString {
//    public static let domain = "https://victor.xpayai.com"
    public static let domain = "https://api2-dev.mslqtech.com"
//    public static let domain = "https://api2.mslqtech.com"
}

enum ErrorCodeString: String {
     case successCodeString200 = "200"
     case failureCodeString400 = "400"
     case failureCodeString401 = "401"
     case failureCodeString403 = "403"
}
