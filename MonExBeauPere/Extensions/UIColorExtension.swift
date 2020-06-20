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
    
    // Custom colors
    static let emerald = UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1.0)
    static let river = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
    static let amethyst = UIColor(red: 155/255, green: 89/255, blue: 182/255, alpha: 1.0)
    static let asphalt = UIColor(red: 52/255, green: 73/255, blue: 94/255, alpha: 1.0)
    static let carrot = UIColor(red: 230/255, green: 126/255, blue: 34/255, alpha: 1.0)
    static let alizarin = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
    
    // Array of custom colors
    static let custom: [UIColor] = [.emerald, .river, .amethyst, .asphalt, .carrot, .alizarin]
    
}
