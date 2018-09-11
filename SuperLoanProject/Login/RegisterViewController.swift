//
//  RegisterViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var cancelButton: UIButton!

    
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    
    @IBOutlet weak var verificationTextfield: UITextField!
    
    var loginSuccessBlock: ((_ user: UserModel) -> Void)?
    
    @IBOutlet weak var loginButtonTitleLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    var gradientLayer: CAGradientLayer?
    
    @IBOutlet weak var blueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.phoneNumberTextfield.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        self.phoneNumberTextfield.keyboardType = .numberPad
        self.verificationTextfield.textColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        self.verificationTextfield.keyboardType = .numberPad
        self.phoneNumberTextfield.delegate = self
        self.verificationTextfield.delegate = self
        self.blueButton.layer.masksToBounds = true
        self.blueButton.layer.cornerRadius = 35/2
        self.sendButton.setTitle("发送验证码", for: .normal)
    
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
            self.gradientLayer?.removeFromSuperlayer()
            let gradientLayer = CAGradientLayer()
            self.gradientLayer = gradientLayer
            gradientLayer.frame = self.blueButton.bounds
           
            gradientLayer.colors = [UIColor(red: 35/255, green: 184/255, blue: 249/255, alpha: 1).cgColor, UIColor(red: 0/255, green: 111/255, blue: 255/255, alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            self.blueButton.layer.addSublayer(gradientLayer)
            return
    }
    
  

    @IBAction func loginButtonOnClick(_ sender: Any) {
        
    }
    
    @IBAction func contractButtonOnClick(_ sender: Any) {
        
        let htmlVc = HTMLViewController()
        htmlVc.hidesBottomBarWhenPushed = true
        htmlVc.urlString = HTMLURLString.contractString
        htmlVc.titleText = "用户协议"
        self.present(htmlVc, animated: true, completion: nil)
    }

    

    @IBAction func cancelButtonOnClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    private func login() {
        
        let text = self.phoneNumberTextfield.text?.replacingOccurrences(of: " ", with: "")
        if text?.count != 11 {
            MBProgressHUD.showMessage(withMessage: "请输入正确手机号码~", toView: self.view)
            return
        }
        
        let code = self.verificationTextfield.text?.replacingOccurrences(of: " ", with: "")
        if code?.count != 6 {
            MBProgressHUD.showMessage(withMessage: "请输入正确的验证码~", toView: self.view)
            return
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LoanMarketNetworking.login(withPhoneNumber: text!, verificationNumber: code!) {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let json):
                let model = LoginModel.loginModel(withJson: json)
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        MBProgressHUD.showMessage(withMessage: "登陆成功~", toView: strongSelf.view)
                        if let block = strongSelf.loginSuccessBlock, let user = model.userModel {
                            block(user)
                        }
                        strongSelf.dismiss(animated: true, completion: nil)
                    default:
                        MBProgressHUD.hide(for: strongSelf.view, animated: false)
                        if let message = model.errorMessage {
                            MBProgressHUD.showMessage(withMessage: message, toView: strongSelf.view)
                        } else {
                            MBProgressHUD.showMessage(withMessage: "登陆失败~", toView: strongSelf.view)
                        }
                    }
                } else {
                    MBProgressHUD.hide(for: strongSelf.view, animated: false)
                    MBProgressHUD.showMessage(withMessage: "登陆失败~", toView: strongSelf.view)
                }
            case .failure(_):
                MBProgressHUD.hide(for: strongSelf.view, animated: false)
                MBProgressHUD.showMessage(withMessage: "登陆失败~", toView: strongSelf.view)
            }
        }

    }
    
    
    @IBAction func sendButtonOnClick(_ sender: Any) {
        
       let text = self.phoneNumberTextfield.text?.replacingOccurrences(of: " ", with: "")
        if text?.count != 11 {
            MBProgressHUD.showMessage(withMessage: "请输入正确手机号码~", toView: self.view)
            return
        }
        self.sendButton.setTitle("重新发送", for: .normal)
        LoanMarketNetworking.acquireVerificationCode(withPhoneNumber: text!) { result in
            switch result {
            case .success(let json):
                let model = VerificationModel.verificationModel(withJson: json)
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        if let message = model.successMessage {
                            MBProgressHUD.showMessage(withMessage: message, toView: self.view)
                        } else {
                            MBProgressHUD.showMessage(withMessage: "获取验证码成功~", toView: self.view)
                        }
                    default:
                        if let message = model.errorMessage {
                            MBProgressHUD.showMessage(withMessage: message, toView: self.view)
                        } else {
                            MBProgressHUD.showMessage(withMessage: "验证码获取失败~", toView: self.view)
                        }
                    }
                } else {
                    MBProgressHUD.showMessage(withMessage: "验证码获取失败~", toView: self.view)
                }
            case .failure(_):
                MBProgressHUD.showMessage(withMessage: "验证码获取失败~", toView: self.view)
            }
        }

    }
    
    
    @IBAction func blueButtonOnClick(_ sender: Any) {
        login()
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldStr = textField.text
        var newStr = (oldStr as NSString?)?.replacingCharacters(in: range, with: string)
        newStr = newStr?.replacingOccurrences(of: " ", with: "")
        if textField === self.phoneNumberTextfield {

            let expression = "^([1]{1}([34578]{1}([0-9]{0,9}+)?)?)?$"
            let regex = try?NSRegularExpression.init(pattern: expression, options: .caseInsensitive)
            let numOfMatches = regex?.matches(in: newStr!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, (newStr?.characters.count)!))

            if numOfMatches?.count == 0 {

                return false
            }

            return self.formatPhoneNumText(textField: textField, range: range, string: string)
        } else {
            if (newStr?.count)! > 6 {
                return false
            }
        }
        return true
    }
    
    private func formatPhoneNumText (textField:UITextField, range:NSRange, string:String) -> Bool {
        
        var text = textField.text!
        
        // 只能输入数字
        let characterSet = NSCharacterSet.init(charactersIn: "0123456789")
        
        let tempString = string.replacingOccurrences(of: " ", with: "")
        if (tempString.rangeOfCharacter(from: characterSet.inverted) != nil) {
            
            return false
        }
        
        text = ((text as NSString?)?.replacingCharacters(in: range, with: string))!
        text = text.replacingOccurrences(of: " ", with: "")
        
        text.insert(" ", at: (text.startIndex))
        var newString = ""
        
        while (text.characters.count) > 0 {
            
            let subString = (text as NSString).substring(to: min(text.characters.count, 4))
            newString = newString.appending(subString)
            if subString.characters.count == 4 {
                
                newString = newString.appending(" ")
            }
            text = (text as NSString).substring(from: min(text.characters.count, 4))
        }
        newString = newString.trimmingCharacters(in: characterSet.inverted)
        
        if newString.characters.count >= 14 {
            
            return false
        }
        
        
        if range.location != textField.text?.characters.count {
            
            textField.text = newString
            
//            if textField == self.phoneTextField {
//
//            }
            
            return false
        }
        
        textField.text = newString
        
//        if textField == self.phoneTextField {
//
//        }
        return false
    }


}



