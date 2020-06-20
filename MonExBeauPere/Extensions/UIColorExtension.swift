//
//  UIColorExtension.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Background color
    static var background: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    // Text color
    static var text: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    
}
