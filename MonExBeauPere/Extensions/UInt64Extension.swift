//
//  UInt64Extension.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

extension UInt64 {
    
    var euroPrice: String? {
        let priceFormatter = NumberFormatter()
        
        priceFormatter.numberStyle = .currency
        priceFormatter.locale = .init(identifier: "fr_FR")
        priceFormatter.maximumFractionDigits = 0
        
        return priceFormatter.string(from: NSNumber(value: self))
    }
    
}
