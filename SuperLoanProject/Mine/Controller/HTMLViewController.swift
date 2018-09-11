//
//  HTMLViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/1.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import MBProgressHUD

class HTMLViewController: UIViewController {
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var titleLabelCenterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backImageView: UIImageView!
    var titleText: String?
    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.backImageView.image = UIImage(named: "back")?.tintWithColor(UIColor.white)
        self.webView.backgroundColor = .white
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.webView.delegate = self
        if let urlString = urlString, let url = URL(string: urlString) {
            let mutableRequest = URLRequest(url: url)
            self.webView.loadRequest(mutableRequest)

        }
        
        if UIScreen.isX() {
            self.statusView.isHidden = false
            self.navigationBarHeightConstraint.constant = 88
            self.titleLabelCenterYConstraint.constant = 16
        } else {
            self.statusView.isHidden = true
        }
        self.titleLabel.text = self.titleText
    }
    
    @IBAction func backButtonOnClick(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.statusView.isHidden = true
    }
    
    
}
extension HTMLViewController : UIWebViewDelegate {
    
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        
        return true
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUD.showAdded(to: self.webView, animated: true)
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.webView, animated: true)
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        MBProgressHUD.hide(for: self.webView, animated: true)
        MBProgressHUD.showMessage(withMessage: "加载失败~", toView: self.view)
    }
}
