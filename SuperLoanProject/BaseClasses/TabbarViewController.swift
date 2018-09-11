//
//  TabbarViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/2.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.didReceiveLoadMoreNotification(_:)), name: Notification.Name(rawValue: NotificationName.LoadMoreNotification), object: nil)
        
    }

    @objc func didReceiveLoadMoreNotification(_ notification: Notification) {
        
        self.selectedIndex = 1
    }

}
