//
//  Array+Extension.swift
//  SuperLoanProject
//
//  Created by Young on 2018/9/3.
//  Copyright © 2018年 Young. All rights reserved.
//

import Foundation

func shuffleArra<T>(arr:[T]) -> [T] {
    var data:[T] = arr
    for i in 1..<arr.count {
        let index:Int = Int(arc4random()) % i
        if index != i {
            data.swapAt(i, index)
        }
    }
    return data
}


