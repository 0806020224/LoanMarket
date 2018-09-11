//
//  String+Extensino.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/2.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation


extension String {
   
    func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
}
