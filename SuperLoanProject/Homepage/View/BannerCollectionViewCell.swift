//
//  BannerCollectionViewCell.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/21.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit
import Kingfisher
class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var advtisementImageView: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    var image: SlideImage? {
        didSet {
            if let urlstring = image?.imageUrl, let url =  URL(string: urlstring) {
                let resource = ImageResource(downloadURL: url)
                advtisementImageView.kf.setImage(with: resource)
            } else {
                advtisementImageView.image = nil
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
