//
//  SettingsSection.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

class SettingsSection {
    
    var name: String
    var elements: [SettingsElement]
    
    init(name: String, elements: [SettingsElement]) {
        self.name = name
        self.elements = elements
    }
    
}
