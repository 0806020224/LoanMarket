//
//  UIImage+Extension.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/21.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation
import UIKit

extension UIImage
{
    func tintWithColor(_ color: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext(),
            let cgImage = self.cgImage else {
                UIGraphicsEndImageContext()
                return UIImage()
        }
        
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: cgImage)
        
        color.setFill()
        
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}
