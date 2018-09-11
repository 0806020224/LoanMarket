//
//  ProductItemTableViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class ProductItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
 
    @IBOutlet weak var rightButton: GradientButton!
    
    @IBOutlet weak var orderLabel: UILabel!
    
    var viewDidClickApplyButtonBlock: (()->())?
    
    var product: HotProduct? {
        didSet {
            if let product = product {
                if let logo = product.logo, let url = URL(string: logo) {
                    let imageResource = ImageResource(downloadURL: url)
                    iconImageView.kf.setImage(with: imageResource)
                } else {
                    iconImageView.image = nil
                }
                
                if let minCredit = product.minCredit, let maxCredit = product.maxCredit {
                    priceLabel.text = minCredit + "~" + maxCredit + "元"
                } else {
                    priceLabel.text = ""
                }
                
                descLabel.text = product.description ?? ""
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.rightButton.layer.masksToBounds = true
        self.rightButton.layer.cornerRadius = 12.5
        self.setUpImageView(with: iconImageView)
        
    }
    
    @IBAction func rightButtonOnClick(_ sender: Any) {
    
        if let block  = self.viewDidClickApplyButtonBlock {
            block()
        }
    
    }
    
    
    private func setUpImageView(with imageView: UIImageView) {
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
    }

}
