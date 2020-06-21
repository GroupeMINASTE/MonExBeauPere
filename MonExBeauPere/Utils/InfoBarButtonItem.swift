//
//  InfoBarButtonItem.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 21/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class InfoBarButtonItem: UIBarButtonItem {
    
    init(_ type: UIButton.ButtonType = .infoLight, target: Any?, action: Selector) {
        super.init()
        let button = UIButton(type: type)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.customView = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
