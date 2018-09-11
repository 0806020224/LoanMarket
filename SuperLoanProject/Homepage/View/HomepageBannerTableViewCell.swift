//
//  HomepageBannerTableViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/20.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher
class HomepageBannerTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewOne: UIView!
    
    @IBOutlet weak var viewTwo: UIView!
    
    @IBOutlet weak var viewThree: UIView!
    
    @IBOutlet weak var buttonOne: UIButton!
    
    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonThree: UIButton!
    
    
    @IBOutlet weak var imageOne: UIImageView!
    
    @IBOutlet weak var imageTwo: UIImageView!
    
    @IBOutlet weak var imageThree: UIImageView!
    
    var subjects: [Subject]? {
        didSet {
            if let subjects = subjects, subjects.count >= 3 {
                if let urlString = subjects[0].imageUrl, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.imageOne.kf.setImage(with: imageSource)
                } else {
                    self.buttonOne.setBackgroundImage(nil, for: .normal)
                }
                
                if let urlString = subjects[1].imageUrl, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.imageTwo.kf.setImage(with: imageSource)
                } else {
                    self.buttonTwo.setBackgroundImage(nil, for: .normal)
                }
                
                if let urlString = subjects[2].imageUrl, let url = URL(string: urlString) {
                    let imageSource = ImageResource(downloadURL: url)
                    self.imageThree.kf.setImage(with: imageSource)
                } else {
                    self.buttonThree.setBackgroundImage(nil, for: .normal)
                }
                
            }
        }
    }
    
    var clickButtonOneBlock: ((_ subject: Subject) -> ())?
    
    var clickButtonTwoBlock: ((_ subject: Subject) -> ())?
    
    var clickButtonThreeBlock: ((_ subject: Subject) -> ())?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        self.viewOne.layer.masksToBounds = true
        self.viewOne.layer.cornerRadius = 2
        
        self.viewTwo.layer.masksToBounds = true
        self.viewTwo.layer.cornerRadius = 2
       
        self.viewThree.layer.masksToBounds = true
        self.viewThree.layer.cornerRadius = 2
     
        self.buttonOne.contentMode = .scaleAspectFill
        self.buttonTwo.contentMode = .scaleAspectFill
        self.buttonThree.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    
    
    @IBAction func buttonOneOnClick(_ sender: Any) {
        if let block = self.clickButtonOneBlock, let subjects = subjects, subjects.count >= 3  {
            block(subjects[0])
        }
    }
    
    
    
    @IBAction func buttonTwoOnClick(_ sender: Any) {
        if let block = self.clickButtonTwoBlock, let subjects = subjects, subjects.count >= 3  {
            block(subjects[1])
        }
    }
    
    
    @IBAction func buttonThreeOnClick(_ sender: Any) {
        if let block = self.clickButtonThreeBlock, let subjects = subjects, subjects.count >= 3  {
            block(subjects[2])
        }
    }
    
}
