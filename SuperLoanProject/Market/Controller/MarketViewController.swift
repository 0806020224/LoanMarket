//
//  MarketViewController.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

private let kMarketTableViewCellReuseID = "com.hsbc.tableview.reuse.cell.MarketTableViewCell.edit"


class MarketViewController: UIViewController {
    
    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var sesameButton: UIButton!
    
    @IBOutlet weak var officeWorkerLoanButton: UIButton!
    
    @IBOutlet weak var phoneNumberLoanButton: UIButton!
    
    @IBOutlet weak var marketTableView: UITableView!
    
    private var hotProducts: [HotProduct]?
    
    private var randomProducts: [HotProduct]?
    
    @IBOutlet weak var topView: UIView!
    var selectedButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor:UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
                ,NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)
                
        ]
        MobClick.event(UMConfigEventId.MarketVisit)
      
        self.title = "贷款超市"
        self.allButton.layer.masksToBounds = true
        self.allButton.layer.cornerRadius = 2
        
        self.sesameButton.layer.masksToBounds = true
        self.sesameButton.layer.cornerRadius = 2
        
        self.officeWorkerLoanButton.layer.masksToBounds = true
        self.officeWorkerLoanButton.layer.cornerRadius = 2
        
        self.phoneNumberLoanButton.layer.masksToBounds = true
        self.phoneNumberLoanButton.layer.cornerRadius = 2
        marketTableView.delegate = self
        marketTableView.dataSource = self
        marketTableView.register(UINib(nibName: "MarketTableViewCell", bundle: nil), forCellReuseIdentifier: kMarketTableViewCellReuseID)
        marketTableView.estimatedRowHeight = 88
        marketTableView.separatorStyle = .none
        marketTableView.rowHeight = UITableViewAutomaticDimension
        self.sesameButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.officeWorkerLoanButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.phoneNumberLoanButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        self.allButton.backgroundColor = UIColor(red: 210/255, green: 228/255, blue: 247/255, alpha: 1)
        self.allButton.setTitleColor(UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1), for: .normal)
        
        
        self.sesameButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        self.officeWorkerLoanButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        self.phoneNumberLoanButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
       
        let header = MJRefreshNormalHeader.init {
            self.getHotProducts()
        }
        header?.lastUpdatedTimeLabel.isHidden = true
        header?.setTitle("下拉重新加载数据", for: .pulling)
        header?.setTitle("下拉重新加载数据", for: .idle)
        header?.setTitle("下拉重新加载数据", for: .willRefresh)
        header?.setTitle("努力加载中...", for: .refreshing)
        marketTableView.mj_header = header
        self.topView.isHidden = true

        getHotProducts()
    }
    
    private func getHotProducts() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        LoanMarketNetworking.getHotProducts {[weak self] result in
            guard let strongSelf = self else { return }
            MBProgressHUD.hide(for: strongSelf.view, animated: true)
            switch result {
            case .success(let json):
                let model = HotProductModel.todayNewProductModel(withJson: json)
                strongSelf.hotProducts = model.products
                strongSelf.randomProducts = model.products
                let errorCode = ErrorCodeString(rawValue: model.errorCode!)
                if let code = errorCode {
                    switch code {
                    case .successCodeString200:
                        strongSelf.topView.isHidden = false
                        strongSelf.marketTableView.reloadData()
                    default:
                        break
                    }
                }
                if strongSelf.marketTableView.mj_header.isRefreshing {
                    strongSelf.marketTableView.mj_header.endRefreshing()
                }
                
            case .failure(_):
                if strongSelf.marketTableView.mj_header.isRefreshing {
                    strongSelf.marketTableView.mj_header.endRefreshing()
                }
                MBProgressHUD.showMessage(withMessage: "网络出错啦~", toView: strongSelf.view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MobClick.beginLogPageView("LoanMarketPage")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("LoanMarketPage")
    }
    func shuffleArra<T>(arr:[T]) -> [T] {
        var data:[T] = arr
        for i in 1..<arr.count {
            let index:Int = Int(arc4random()) % i
            if index != i {
                data.swapAt(i, index)
            }
        }
        return data
    }
    
    @IBAction func allButtonOnClikc(_ sender: UIButton) {
        if selectedButton === sender {
            return
        }
        configButtons(selectedButton: sender)
        self.hotProducts = self.randomProducts
        self.marketTableView.reloadData()
    }
    
    
    @IBAction func sesameButtonOnClick(_ sender: UIButton) {
        if selectedButton === sender {
            return
        }
        configButtons(selectedButton: sender)
        self.hotProducts = self.shuffleArra(arr: self.hotProducts!)
        self.marketTableView.reloadData()
    }
    
    @IBAction func officeWorkerButtonOnClick(_ sender: UIButton) {
        if selectedButton === sender {
            return
        }
        self.hotProducts = self.shuffleArra(arr: self.hotProducts!)
        self.marketTableView.reloadData()
        configButtons(selectedButton: sender)
    }
    
   
    @IBAction func phoneButtonOnClick(_ sender: UIButton) {
        if selectedButton === sender {
            return
        }
        self.hotProducts = self.shuffleArra(arr: self.hotProducts!)
        self.marketTableView.reloadData()
        configButtons(selectedButton: sender)
    }
    
    private func configButtons(selectedButton: UIButton) {
        self.selectedButton = selectedButton
        self.allButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.sesameButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.officeWorkerLoanButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        self.phoneNumberLoanButton.backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        
        self.allButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        self.sesameButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        self.officeWorkerLoanButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        self.phoneNumberLoanButton.setTitleColor(UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1), for: .normal)
        
        
        selectedButton.backgroundColor = UIColor(red: 210/255, green: 228/255, blue: 247/255, alpha: 1)
        selectedButton.setTitleColor(UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1), for: .normal)
      
    }

}



//MARK: UITableViewDataSource
extension MarketViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotProducts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMarketTableViewCellReuseID, for: indexPath) as! MarketTableViewCell
        if let products = self.hotProducts {
            cell.product = products[indexPath.row]
        }

        return cell
    }
}

//MARK: UITableViewDelegate
extension MarketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let products = self.hotProducts {
            
            let viewController = ProductDetailViewController()
            viewController.hotProduct = products[indexPath.row]
                viewController.hidesBottomBarWhenPushed = true
//            viewController.modalTransitionStyle = .flipHorizontal
            present(viewController, animated: true, completion: nil)
        }
    }
}

