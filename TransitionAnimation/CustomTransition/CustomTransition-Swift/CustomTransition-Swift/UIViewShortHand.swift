//
//  UIViewShortHand.swift
//  CustomTransition-Swift
//
//  Created by 张星宇 on 16/2/8.
//  Copyright © 2016年 zxy. All rights reserved.
//

import Foundation
import UIKit

extension Collection where Iterator.Element == Int {
    public var color: UIColor {
        guard self.count == 3 else { fatalError("You should specify R,G,B values with 3 integers") }
        let r = CGFloat(self[startIndex]) / CGFloat(255)
        let g = CGFloat(self[index.index(startIndex, offsetBy: 1)]) / CGFloat(255)
        let b = CGFloat(self[index.index(startIndex, offsetBy: 2)]) / CGFloat(255)
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
