//
//  FourItemsTableViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher

class FourItemsTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageOne: UIImageView!
    
    @IBOutlet weak var iconImageTwo: UIImageView!
    
    @IBOutlet weak var iconImageThree: UIImageView!
    
    @IBOutlet weak var iconImageFour: UIImageView!
    
    
    @IBOutlet weak var applyButtonOne: UIButton!
    @IBOutlet weak var applyButtonTwo: UIButton!
    @IBOutlet weak var applyButtonThree: UIButton!
    @IBOutlet weak var applyButtonFour: UIButton!
    
    
    @IBOutlet weak var nameOneLabel: UILabel!
    @IBOutlet weak var nameTwoLabel: UILabel!
    @IBOutlet weak var nameThreeLabel: UILabel!
    @IBOutlet weak var nameFourLabel: UILabel!
    
    @IBOutlet weak var creditOneLabel: UILabel!
    @IBOutlet weak var creditTwoLabel: UILabel!
    @IBOutlet weak var creditThreeLabel: UILabel!
    @IBOutlet weak var creditFourLabel: UILabel!
    
    
    var products: [TodayNewProduct]? {
        didSet {
            setupCell()
        }
    }
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var viewTwo: UIView!
    
    @IBOutlet weak var viewThree: UIView!
    
    @IBOutlet weak var viewFour: UIView!
    
    
    @IBOutlet weak var coverButtonOne: UIButton!
    
    @IBOutlet weak var coverButtonTwo: UIButton!
    
    @IBOutlet weak var coverButtonThree: UIButton!
    
    @IBOutlet weak var coverButtonFour: UIButton!
    
    var coverButtonOneOnClickBlock: ((_ model: TodayNewProduct) -> ())?
    var coverButtonTwoOnClickBlock: ((_ model: TodayNewProduct) -> ())?
    var coverButtonThreeOnClickBlock: ((_ model: TodayNewProduct) -> ())?
    var coverButtonFourOnClickBlock: ((_ model: TodayNewProduct) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setUpImageView(with: iconImageOne)
        self.setUpImageView(with: iconImageTwo)
        self.setUpImageView(with: iconImageThree)
        self.setUpImageView(with: iconImageFour)
        
    }
    
 
    func setupCell() {
        if let products = products {
            if products.count >= 4 {
                
                if let urlString = products[0].logo, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.iconImageOne.kf.setImage(with: imageSource)
                    
                } else {
                    self.iconImageOne.image = nil
                }
                
                if let urlString = products[1].logo, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.iconImageTwo.kf.setImage(with: imageSource)
                    
                } else {
                    self.iconImageTwo.image = nil
                }
                
                if let urlString = products[2].logo, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.iconImageThree.kf.setImage(with: imageSource)
                    
                } else {
                    self.iconImageThree.image = nil
                }
                
                if let urlString = products[3].logo, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.iconImageFour.kf.setImage(with: imageSource)
                    
                    
                } else {
                    self.iconImageFour.image = nil
                }
                
                
                let productOne = products[0]
                self.nameOneLabel.text = productOne.name ?? ""
                self.creditOneLabel.text = "最高 \(productOne.maxCredit ?? "") 元"
                
                let productTwo = products[1]
                self.nameTwoLabel.text = productTwo.name ?? ""
                self.creditTwoLabel.text = "最高 \(productTwo.maxCredit ?? "") 元"
                
                let productThree = products[2]
                self.nameThreeLabel.text = productThree.name ?? ""
                self.creditThreeLabel.text = "最高 \(productThree.maxCredit ?? "") 元"
                
                let productFour = products[3]
                self.nameFourLabel.text = productFour.name ?? ""
                self.creditFourLabel.text = "最高 \(productFour.maxCredit ?? "") 元"
            }
            self.applyButtonOne.setTitle("立即申请", for: .normal)
            self.applyButtonTwo.setTitle("立即申请", for: .normal)
            self.applyButtonThree.setTitle("立即申请", for: .normal)
            self.applyButtonFour.setTitle("立即申请", for: .normal)
        }
        
    }
    
    @IBAction func coverButtonOneOnClick(_ sender: Any) {
        if let block = coverButtonOneOnClickBlock {
             if let products = products {
                if products.count >= 4 {
                    block(products[0])
                }
            }
        }
    }
    
    @IBAction func coverButtonTwoOnClick(_ sender: Any) {
        if let block = coverButtonTwoOnClickBlock {
            if let products = products {
                if products.count >= 4 {
                    block(products[1])
                }
            }
        }
    }
    
    @IBAction func coverButtonThreeOnClick(_ sender: Any) {
        if let block = coverButtonThreeOnClickBlock {
            if let products = products {
                if products.count >= 4 {
                    block(products[2])
                }
            }
        }
    }
    
    @IBAction func coverButtonFourOnClick(_ sender: Any) {
        if let block = coverButtonFourOnClickBlock {
            if let products = products {
                if products.count >= 4 {
                    block(products[3])
                }
            }
        }
    }
    
    
    
    private func setUpImageView(with imageView: UIImageView) {
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
    }
    
}
