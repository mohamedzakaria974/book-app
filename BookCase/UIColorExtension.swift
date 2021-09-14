//
//  UIColorExtension.swift
//  BookCase
//
//  Created by Mohamed Zakaria on 5/11/18.
//  Copyright © 2018 Mohamed Zakaria. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

// MARK: - Extension: Custom App UIColors
extension UIColor {
    struct BookCaseColors{
        static let darkBlueForTranslucentItems = UIColor(netHex: 0x20405D)
        static let darkBlue = UIColor(netHex: 0x38536D)
        static let lightBlue = UIColor(netHex: 0x8F9FAE)
    }
}
