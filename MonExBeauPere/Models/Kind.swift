//
//  Kind.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 27/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

class Kind: Equatable {
    
    // Static values
    static let other = Kind(0, verb: "ne fait rien")
    static let food = Kind(1, verb: "se régale")
    static let person = Kind(2, verb: "s'amuse")
    static let entertainment = Kind(3, verb: "s'amuse")
    
    // Properties
    let id: Int
    let verb: String
    
    // Initializer
    init(_ id: Int, verb: String) {
        self.id = id
        self.verb = verb
    }
    
    // Equatable
    static func == (lhs: Kind, rhs: Kind) -> Bool {
        return lhs.id == rhs.id
    }
    
}
