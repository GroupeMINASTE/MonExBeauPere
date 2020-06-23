//
//  OwnedGift.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 23/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

class OwnedGift {
    
    // Properties
    var gift: Gift
    var amount: Int
    var id: Int { gift.id }
    var name: String { gift.name }
    var value: UInt64 { gift.value }
    
    // Initializer
    init(_ gift: Gift, amount: Int) {
        self.gift = gift
        self.amount = amount
    }
    
}
