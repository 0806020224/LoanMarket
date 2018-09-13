//
//  SpecifiSubjectViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

private let kMarketTableViewCellReuseID = "com.hsbc.tableview.reuse.cell.MarketTableViewCell.edit"

class SpecifiSubjectViewController: UIViewController {
    
    var subject: Subject?
    var subjectDetail: SubjectDetailModel?
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var navigationBarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backImageViewCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "专题详情"
        self.view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MarketTableViewCell", bundle: nil), forCellReuseIdentifier: kMarketTableViewCellReuseID)
        tableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: kBannerTableViewCellID)
        tableView.separatorStyle = .none
        getSubjectDetail()
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.white
                ,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)]
       
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 74/255, green: 144/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 74/255, green: 144/255, blue: 255/255, alpha: 1)
        
        if !UIScreen.isX() {
           self.blueView.isHidden = true
        } else {
            self.navigationBarHeightConstraint.constant = 88
            self.backImageViewCenterYConstraint.constant = 20
        }
    }
    
    
    
    private func getSubjectDetail() {
        if let subject = self.subject, let subjectID = subject.productId {
            LoanMarketNetworking.subjectDetail(productID: subjectID) {[weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let json):
                    let model = SubjectDetailModel.subjectDetailModel(withJson: json)
                    strongSelf.subjectDetail = model
                    let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                    if let code = errorCode {
                        switch code {
                        case .successCodeString200:
                            strongSelf.tableView.reloadData()
                        default:
                            break
                        }
                    }
                case .failure(_):
                    MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
                }
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.isTranslucent = false
        
        let rect = self.allView.convert(self.tableView.frame, to: UIScreen.main.coordinateSpace)
        print("\(rect)")
    }
    
    
    @IBAction func backButtonOnClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
            self.blueView.isHidden = true
    }
    
 
}
//MARK: UITableViewDataSource
extension SpecifiSubjectViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.subjectDetail?.subjectDetailData?.subjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kBannerTableViewCellID, for: indexPath) as! BannerTableViewCell
            if let subjectDetailData = self.subjectDetail?.subjectDetailData {
                let image = SlideImage()
                image.imageUrl = subjectDetailData.bannerUrl
                cell.advertisementArr = [image]
            }
            
            return cell
        } 
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kMarketTableViewCellReuseID, for: indexPath) as! MarketTableViewCell
        if let subjects = self.subjectDetail?.subjectDetailData?.subjects {
            let product = subjects[indexPath.row]
            cell.product = product
        }
        
        return cell
    }
}

//MARK: UITableViewDelegate
extension SpecifiSubjectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {

            return 160
           
        } else if indexPath.section == 1 {
            
            return UITableViewAutomaticDimension
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            return 160
            
        } else if indexPath.section == 1 {
            
            return UITableViewAutomaticDimension
            
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = ProductDetailViewController()
        if let subjects = self.subjectDetail?.subjectDetailData?.subjects {
            let product = subjects[indexPath.row]
            vc.hotProduct = product
        }
        self.present(vc, animated: true, completion: nil)
    }
}
