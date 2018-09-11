//
//  HomepageViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

let kHomepageBannerTableViewCellReuseID = "collectionview.reuse.HomepageBannerTableViewCell"
let kBannerTableViewCellID = "collectionview.reuse.BannerTableViewCell"
let kHompageHeaderTableViewCellID = "collectionview.reuse.HompageHeaderTableViewCell"
let kFourItemsTableViewCellID = "collectionview.reuse.FourItemsTableViewCell"
let kProductItemTableViewCellID = "collectionview.reuse.ProductItemTableViewCell"
let kLoadMoreTableViewCellID = "collectionview.reuse.LoadMoreTableViewCell"



public let ScreenWidth = UIScreen.main.bounds.size.width

class HomepageViewController: UIViewController {

    
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var homepageTableView: UITableView!
    private var images: [SlideImage]?
    private var subjects: [Subject]?
    private var products: [TodayNewProduct]?
    private var hotProducts: [HotProduct]?
    @IBOutlet weak var allView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MobClick.event(UMConfigEventId.HomePageVisit)
        self.navigationController?.view.backgroundColor = .white
        self.allView.isHidden = true
        homepageTableView.delegate = self
        homepageTableView.dataSource = self
        homepageTableView.separatorStyle = .none
        homepageTableView.register(UINib(nibName: "HomepageBannerTableViewCell", bundle: nil), forCellReuseIdentifier: kHomepageBannerTableViewCellReuseID)
        homepageTableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: kBannerTableViewCellID)
        homepageTableView.register(UINib(nibName: "HompageHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: kHompageHeaderTableViewCellID)
        homepageTableView.register(UINib(nibName: "FourItemsTableViewCell", bundle: nil), forCellReuseIdentifier: kFourItemsTableViewCellID)

        homepageTableView.register(UINib(nibName: "ProductItemTableViewCell", bundle: nil), forCellReuseIdentifier: kProductItemTableViewCellID)
        
        homepageTableView.register(UINib(nibName: "LoadMoreTableViewCell", bundle: nil), forCellReuseIdentifier: kLoadMoreTableViewCellID)
        
        if !UIScreen.isX() {
            self.viewTopConstraint.constant = -44
        }
        let header = MJRefreshNormalHeader.init {
            self.getSlideImages()
        }
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.setTitle("下拉重新加载数据", for: .pulling)
        header?.setTitle("下拉重新加载数据", for: .idle)
        header?.setTitle("下拉重新加载数据", for: .willRefresh)
        header?.setTitle("努力加载中...", for: .refreshing)
        homepageTableView.mj_header = header
        
        let infoDictionary = Bundle.main.infoDictionary
        var tokenValue: String? = nil
        
        var headerParams = ["Accept": "application/json"]
        headerParams["os"] = UIDevice.current.systemVersion
        headerParams["version"] =  infoDictionary? ["CFBundleShortVersionString"] as? String
  
        print("\(headerParams)")
        getSlideImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        self.navigationController?.navigationBar.isHidden = false
    }

}
extension HomepageViewController {
    
    private func getSlideImages() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LoanMarketNetworking.getSlideImages {[weak self ] result in
            guard let strongSelf = self else { return }
                switch result {
                case .success(let json):
                    let model = SlideImageModel.slideImageModel(withJson: json)
                    strongSelf.images = model.images
                    let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                    if let code = errorCode {
                        switch code {
                        case .successCodeString200:
                            strongSelf.getSubjects()
                        default:
                            if strongSelf.homepageTableView.mj_header.isRefreshing {
                                strongSelf.homepageTableView.mj_header.endRefreshing()
                            }
                            MBProgressHUD.hide(for: strongSelf.view, animated: true)
                        }
                    }
                case .failure(_):
                    if strongSelf.homepageTableView.mj_header.isRefreshing {
                        strongSelf.homepageTableView.mj_header.endRefreshing()
                    }
                    MBProgressHUD.hide(for: strongSelf.view, animated: true)
                    MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
                }
            }
    }
    
    private func getSubjects() {
        LoanMarketNetworking.getSubjects {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let json):
                let model = SubjectModel.subjectModel(withJson: json)
                strongSelf.subjects = model.subjects
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        strongSelf.getTodayNewProducts()
                    default:
                        if strongSelf.homepageTableView.mj_header.isRefreshing {
                            strongSelf.homepageTableView.mj_header.endRefreshing()
                        }
                       MBProgressHUD.hide(for: strongSelf.view, animated: true)
                    }
                }
            case .failure(_):
                if strongSelf.homepageTableView.mj_header.isRefreshing {
                    strongSelf.homepageTableView.mj_header.endRefreshing()
                }
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
            }
        }
        
    }
    
    private func getTodayNewProducts() {
        LoanMarketNetworking.getTodayNewProducts {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let json):
                let model = TodayNewProductModel.todayNewProductModel(withJson: json)
                strongSelf.products = model.products
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        strongSelf.getHotProducts()
                    default:
                        if strongSelf.homepageTableView.mj_header.isRefreshing {
                            strongSelf.homepageTableView.mj_header.endRefreshing()
                        }
                        MBProgressHUD.hide(for: strongSelf.view, animated: true)
                    }
                }
            case .failure(_):
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                if strongSelf.homepageTableView.mj_header.isRefreshing {
                    strongSelf.homepageTableView.mj_header.endRefreshing()
                }
                MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
            }
        }
    }
    
    private func getHotProducts() {
        LoanMarketNetworking.getHotProducts {[weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let json):
                let model = HotProductModel.todayNewProductModel(withJson: json)
                strongSelf.hotProducts = model.products
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        strongSelf.homepageTableView.reloadData()
                        strongSelf.allView.isHidden = false
                    default:
                        break
                    }
                }
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                if strongSelf.homepageTableView.mj_header.isRefreshing {
                    strongSelf.homepageTableView.mj_header.endRefreshing()
                }
            case .failure(_):
                MBProgressHUD.hide(for: strongSelf.view, animated: true)
                if strongSelf.homepageTableView.mj_header.isRefreshing {
                    strongSelf.homepageTableView.mj_header.endRefreshing()
                }
                MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
            }
        }
    }
}



//MARK: UITableViewDataSource
extension HomepageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else if section == 1 {
            if let hotProducts = self.hotProducts {
                return hotProducts.count
            }
            return 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: kBannerTableViewCellID, for: indexPath) as! BannerTableViewCell
                if let images = self.images {
                    cell.advertisementArr = images
                }
                
                cell.didSelectBannerBlock = { model in
                    let vc = ProductDetailViewController()
                    let product = HotProduct()
                    product.productId = model.productId
                    vc.hotProduct = product
                    self.present(vc, animated: true, completion: nil)
                    MobClick.event(UMConfigEventId.BannerAdvertisement)
                }
                return cell
            } else if indexPath.row == 1 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomepageBannerTableViewCellReuseID, for: indexPath) as! HomepageBannerTableViewCell
                cell.subjects = self.subjects
                cell.clickButtonOneBlock = { subject in
                    let viewController = SpecifiSubjectViewController()
                    viewController.subject = subject
                    viewController.hidesBottomBarWhenPushed = true
                    self.show(viewController, sender: nil)
                    
                    MobClick.event(UMConfigEventId.HomePageSubject)
                }
                
                cell.clickButtonTwoBlock = { subject in
                    let viewController = SpecifiSubjectViewController()
                    viewController.subject = subject
                    viewController.hidesBottomBarWhenPushed = true
                    self.show(viewController, sender: nil)
                    MobClick.event(UMConfigEventId.HomePageSubject)
                }
                
                cell.clickButtonThreeBlock = { subject in
                    let viewController = SpecifiSubjectViewController()
                    viewController.subject = subject
                    viewController.hidesBottomBarWhenPushed = true
                    self.show(viewController, sender: nil)
                    MobClick.event(UMConfigEventId.HomePageSubject)
                }
                return cell
                
            } else if indexPath.row == 2 || indexPath.row == 4{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: kHompageHeaderTableViewCellID, for: indexPath) as! HompageHeaderTableViewCell
                
                if indexPath.row == 2 {
                    cell.titleLabel.text = "今日新品"
                    cell.subTitleLabel.text = "新品上线，通过率高，下款快"
                } else {
                    cell.titleLabel.text = "热门榜单"
                    cell.subTitleLabel.text = "靠谱产品，额度高"
                }
                
                return cell
                
            } else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: kFourItemsTableViewCellID, for: indexPath) as! FourItemsTableViewCell
                if let products = self.products {
                    cell.products = products
                }
                cell.coverButtonOneOnClickBlock = { model in
                    MobClick.event(UMConfigEventId.HomePagePromotion)
                    let vc = ProductDetailViewController()
                    let product = HotProduct()
                    product.productId = model.productId
                    vc.hotProduct = product
                    self.present(vc, animated: true, completion: nil)
                }
                
                cell.coverButtonTwoOnClickBlock = { model in
                    MobClick.event(UMConfigEventId.HomePagePromotion)
                    let vc = ProductDetailViewController()
                    let product = HotProduct()
                    product.productId = model.productId
                    vc.hotProduct = product
                    self.present(vc, animated: true, completion: nil)
                }
                
                cell.coverButtonThreeOnClickBlock = { model in
                    MobClick.event(UMConfigEventId.HomePagePromotion)
                    let vc = ProductDetailViewController()
                    let product = HotProduct()
                    product.productId = model.productId
                    vc.hotProduct = product
                    self.present(vc, animated: true, completion: nil)
                }
                
                cell.coverButtonFourOnClickBlock = { model in
                    MobClick.event(UMConfigEventId.HomePagePromotion)
                    let vc = ProductDetailViewController()
                    let product = HotProduct()
                    product.productId = model.productId
                    vc.hotProduct = product
                    self.present(vc, animated: true, completion: nil)
                }
                
                return cell
                
            } 
            
            
        } else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: kProductItemTableViewCellID, for: indexPath) as! ProductItemTableViewCell
            if let hotProducts = self.hotProducts {
                cell.product = hotProducts[indexPath.row]
            }
            
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
                cell.orderLabel.textColor = UIColor(red: 245/255, green: 179/255, blue: 38/255, alpha: 1)
            } else {
                cell.orderLabel.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
            }
            cell.orderLabel.text = "\(indexPath.row + 1)"
                return cell
                
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: kLoadMoreTableViewCellID, for: indexPath) as! LoadMoreTableViewCell
            
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: UITableViewDelegate
extension HomepageViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                return 160
            } else if indexPath.row == 1 {
                
                return 70
                
            } else if indexPath.row == 2 || indexPath.row == 4{
                
                return 50
                
            } else if indexPath.row == 3 {
                
                return 190
                
            }
        } else if indexPath.section == 1 {
            
            return 70
        } else {
           
            return 44
        }
         return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
       if indexPath.section == 1 {
        
            let vc = ProductDetailViewController()
            if let hotProducts = self.hotProducts {
                vc.hotProduct = hotProducts[indexPath.row]
            }
            self.present(vc, animated: true, completion: nil)
            MobClick.event(UMConfigEventId.HomePageProductsList)
       }
       
        if indexPath.section == 2 {
            NotificationCenter.default.post(Notification(name: Notification.Name.init(rawValue: NotificationName.LoadMoreNotification), object: nil, userInfo: nil))
        }

    }
}


