//
//  MineViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    
    @IBOutlet weak var iconImageView: UIButton!
    @IBOutlet weak var aboutUsButton: UIButton!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.layer.cornerRadius = 30
        
        if UIScreen.isX() {
            self.topConstraint.constant = -25
        }
    
    }
    
    @IBAction func aboutUsButtonOnClick(_ sender: Any) {
        let htmlVc = HTMLViewController()
        htmlVc.titleText = "关于我们"
        htmlVc.urlString = HTMLURLString.aboutUsString
        self.present(htmlVc, animated: true, completion: nil)
    }
    
    @IBAction func settingButtonOnClick(_ sender: Any) {
        
//        let htmlVc = HTMLViewController()
//        htmlVc.urlString = HTMLURLString.AboutUsString
//        show(htmlVc, sender: nil)
    }
    
    
    @IBAction func iconButtonOnClick(_ sender: Any) {
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        vc.loginSuccessBlock = { user in
            self.phoneNumberLabel.text = user.phone?.replacePhone()
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        if let user = UserManager.shareInstance.user {
            self.phoneNumberLabel.text = user.phone?.replacePhone()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
}
