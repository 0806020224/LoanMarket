//
//  ProductDetailViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var limitLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var applyButton: GradientButton!
    @IBOutlet weak var applyLabel: UILabel!
    private var gradientLayer: CAGradientLayer?
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var backButtonConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var topBlueView: UIView!
    @IBOutlet weak var infoViewTopConstraint: NSLayoutConstraint!
    var hotProduct: HotProduct?
    var productShown: HotProduct?
    override func viewDidLoad() {
        super.viewDidLoad()
        MobClick.event(UMConfigEventId.ProductDetailPageVisit)
        self.tableViewHeightConstraint.constant = 0
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ApplyConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: "ApplyConditionsTableViewCell")
        tableView.separatorStyle = .none
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        self.backImageView.image = UIImage(named: "back")?.tintWithColor(UIColor.white)
        
        self.infoView.layer.cornerRadius = 4
        self.infoView.layer.masksToBounds = true
        self.infoView.layer.borderColor = UIColor.lightGray.cgColor
        self.infoView.layer.borderWidth = 0.5
        
        self.infoView.layer.shadowOffset =  CGSize(width: 1, height: 1)
        self.infoView.layer.shadowColor = UIColor.green.cgColor
        self.infoView.layer.shadowOpacity = 0.8
        
        self.applyButton.layer.cornerRadius = 35/2
        self.applyButton.layer.masksToBounds = true
        
        if UIScreen.isX() {
            self.topConstraint.constant = 10
            self.backButtonConstraint.constant = 30
            self.infoViewTopConstraint.constant = 74
        } else {
            self.topBlueView.isHidden = true
//            self.topConstraint.constant = -20
//            self.backButtonConstraint.constant = 20
//            self.infoViewTopConstraint.constant = 64
        }
        
        iconImageView.layer.borderWidth = 0.5
        iconImageView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 4
        
        getProductDetail()
    }
    
    private func getProductDetail() {
        guard let productID = hotProduct?.productId else { return }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LoanMarketNetworking.getProductDetail(productID: productID) {[weak self] result in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            switch result {
            case .success(let json):
                let model = ProductDetailModel.productDetailModel(withJson: json)
                strongSelf.productShown = model.product
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        strongSelf.tableView.reloadData()
                        strongSelf.tableViewHeightConstraint.constant = CGFloat((model.product?.applyConditions?.count)! * 30)
                        strongSelf.view.layoutIfNeeded()
                        strongSelf.view.setNeedsLayout()
                        strongSelf.configDetailInfo()
                    default:
                        break
                    }
                }
            case .failure(_):
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
            }
        }
    }
    
    private func configDetailInfo() {
        if let product = self.productShown {
            if let urlString = product.logo, let url = URL(string: urlString) {
                let imageSource = ImageResource(downloadURL: url)
                self.iconImageView.kf.setImage(with: imageSource)
                
            } else {
                self.iconImageView.image = nil
            }
            
            self.nameLabel.text = product.name ?? ""
            self.descLabel.text = product.description ?? ""
            self.periodLabel.text = product.loanPeriod ?? ""
            self.limitLabel.text = (product.minCredit ?? "") + "~" + (product.maxCredit ?? "")
            self.timeLabel.text = product.auditTime ?? ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
//        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    @IBAction func applyButtonOnClick(_ sender: Any) {
        guard UserManager.shareInstance.user != nil else {
            let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
            self.present(vc, animated: true, completion: nil)
            return
        }
        
        let htmlVc = HTMLViewController()
        htmlVc.hidesBottomBarWhenPushed = true
        htmlVc.urlString = self.productShown?.link
        htmlVc.titleText = self.productShown?.name
        self.present(htmlVc, animated: true, completion: nil)
    }
    
    
    @IBAction func backButtonOnClikc(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        self.topBlueView.isHidden = true
    }
    
}

//MARK: UITableViewDataSource
extension ProductDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productShown?.applyConditions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplyConditionsTableViewCell", for: indexPath) as! ApplyConditionsTableViewCell
        if let contents = self.productShown?.applyConditions {
           let title = contents[indexPath.row]
           cell.contentLabel.text = " · " + (title.content ?? "")
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
