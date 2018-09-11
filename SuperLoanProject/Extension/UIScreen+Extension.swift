//
//  UIScreen+Extension.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation
import UIKit

extension UIScreen {
    static public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {
            return true
        }
        
        return false
    }
}
