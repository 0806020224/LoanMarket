//
//  MarketTableViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/19.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import QuartzCore
import Kingfisher

class MarketTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var applyButton: GradientButton!
    
    @IBOutlet weak var allView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var decLabel: UILabel!
    
    var cellDidApplyButtonBlock: (()->())?
    
    var product: HotProduct? {
        didSet {
            if let product = product {
                if let url = product.logo, let urlString = URL(string: url) {
                    let resource = ImageResource(downloadURL: urlString)
                    self.iconImageView.kf.setImage(with: resource)
                } else {
                    self.iconImageView.image = nil
                }
                
                if let name = product.name, let downLoadCounts = product.downLoadCounts {
                    self.nameLabel.text = name + " · " + downLoadCounts + "成功下载"
                } else {
                    self.nameLabel.text = ""
                }
                
                if let maxCredit = product.maxCredit, let minCredit = product.minCredit {
                    self.priceLabel.text = minCredit + "~"  + maxCredit
                } else {
                    self.priceLabel.text = ""
                }
                
                if let description = product.description {
                    self.decLabel.text = description
                } else {
                    self.decLabel.text = ""
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.applyButton.layer.masksToBounds = true
        self.applyButton.layer.cornerRadius = 12.5
        
        self.iconImageView.layer.masksToBounds = true
        self.iconImageView.layer.borderWidth = 0.5
        self.iconImageView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        self.iconImageView.layer.cornerRadius = 2
        
   }
    
    @IBAction func applyButtonOnClick(_ sender: Any) {
        if let block = cellDidApplyButtonBlock {
            block()
        }
        
    }
    
    
}

