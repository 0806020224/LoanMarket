//
//  HomepageNavigationViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/3.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class HomepageNavigationViewController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        
        guard viewControllers.count > 1 else { return }
        let btn = UIButton()
        btn.setImage(UIImage(named: "back")?.tintWithColor(UIColor.white), for: .normal)
        btn.bounds = CGRect(x: 0, y: 0, width: 60, height: 44)
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -55, bottom: 0, right: 0)
       
        btn.addTarget(self, action: #selector(popPreviousViewController), for: .touchUpInside)
        let item = UIBarButtonItem(customView: btn)
        viewController.navigationItem.leftBarButtonItem = item
        viewController.navigationItem.hidesBackButton = true
        
        viewController.navigationController?.interactivePopGestureRecognizer?.delegate = self
        viewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    @objc
    private func popPreviousViewController() {
        self.popViewController(animated: true)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
