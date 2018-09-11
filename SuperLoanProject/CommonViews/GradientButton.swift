//
//  GradientButton.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/21.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class GradientButton: UIButton {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let compoents:[CGFloat] = [35/255, 184/255, 249/255, 1,
                                   0/255, 111/255, 255/255, 1]
        

        let locations:[CGFloat] = [0,1]

        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
        

        let start = CGPoint(x: self.bounds.minX, y: self.bounds.minY)

        let end = CGPoint(x: self.bounds.maxX, y: self.bounds.minY)

        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }

}
