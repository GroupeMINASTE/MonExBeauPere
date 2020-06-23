//
//  GiftTableViewCell.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 23/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class GiftTableViewCell: UITableViewCell {

    let name = UILabel()
    let price = UILabel()
    let amount = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(name)
        contentView.addSubview(price)
        contentView.addSubview(amount)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        name.font = UIFont.systemFont(ofSize: 17)
        
        price.translatesAutoresizingMaskIntoConstraints = false
        price.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        price.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        price.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        price.font = UIFont.systemFont(ofSize: 15)
        price.textColor = .systemGray
        
        amount.translatesAutoresizingMaskIntoConstraints = false
        amount.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        amount.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        amount.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        amount.font = UIFont.systemFont(ofSize: 15)
        amount.textColor = .systemGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(gift: OwnedGift) -> GiftTableViewCell {
        name.text = gift.name
        price.text = gift.value.euroPrice
        amount.text = "x\(gift.amount)"
        
        return self
    }

}
