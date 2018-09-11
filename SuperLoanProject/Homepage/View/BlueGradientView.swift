//
//  BlueGradientView.swift
//  SuperLoanProject
//
//  Created by Young on 2018/8/25.
//  Copyright © 2018年 Young. All rights reserved.
//

import UIKit

class BlueGradientView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let compoents:[CGFloat] = [0/255, 224/255, 228/255, 1,
                                   0/255, 207/255, 212/255, 1,
                                   0/255, 189/255, 196/255, 1]
        
        
        let locations:[CGFloat] = [0,0.5,1.0]
        
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: compoents,
                                  locations: locations, count: locations.count)!
        
        
        let start = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        
        let end = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
        
        context.drawLinearGradient(gradient, start: start, end: end,
                                   options: .drawsBeforeStartLocation)
    }

}
