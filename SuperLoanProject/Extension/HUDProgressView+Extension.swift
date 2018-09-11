//
//  HUDProgressView+Extension.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation

extension MBProgressHUD {
    class func showMessage(withMessage string: String, toView: UIView) {
        let hud = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.mode = .text
        hud.label.text = string
        hud.label.font = UIFont.systemFont(ofSize: 14)
        hud.label.textColor = UIColor.darkGray
        hud.hide(animated: true, afterDelay: 1)
    }
}
