//
//  SwitchTableViewCell.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    let label = UILabel()
    let switchElement = UISwitch()
    var id = ""
    var preference = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(label)
        contentView.addSubview(switchElement)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        label.font = UIFont.systemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        
        switchElement.translatesAutoresizingMaskIntoConstraints = false
        switchElement.centerYAnchor.constraint(equalTo: contentView.layoutMarginsGuide.centerYAnchor).isActive = true
        switchElement.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10).isActive = true
        switchElement.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        switchElement.addTarget(self, action: #selector(onChange(_:)), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(id: String = "", text: String, preference: Bool = false, enabled: Bool) -> SwitchTableViewCell {
        self.id = id
        self.preference = preference
        label.text = text
        switchElement.isOn = enabled
        
        return self
    }
    
    @objc func onChange(_ sender: Any) {
        if preference {
            let datas = UserDefaults.standard
            datas.set(switchElement.isOn, forKey: id)
            datas.synchronize()
        }
    }

}
