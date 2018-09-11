//
//  YellowGradientView.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/25.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class YellowGradientView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let compoents:[CGFloat] = [249/255, 210/255, 61/255, 1,
                                   249/255, 179/255, 38/255, 1]
        
        
        let locations:[CGFloat] = [0,1.0]
        
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
        
        
        let start = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        
        let end = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }

}
