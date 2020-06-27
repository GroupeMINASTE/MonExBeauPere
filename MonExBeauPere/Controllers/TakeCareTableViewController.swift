//
//  TakeCareTableViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 27/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class TakeCareTableViewController: UITableViewController {

    // Data shown in tableView
    let kind: Kind
    let completionHandler: (Gift) -> ()
    var gifts = [OwnedGift]()
    
    // Initializer
    init(kind: Kind, completionHandler: @escaping (Gift) -> ()) {
        // Save kind
        self.kind = kind
        self.completionHandler = completionHandler
        
        // Init table view
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation
        navigationItem.title = "Choisir un élément"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(close(_:)))
        
        // Register cells
        tableView.register(GiftTableViewCell.self, forCellReuseIdentifier: "giftCell")
        
        // Update wealth and gifts datas
        updateWealth()
    }
    
    func updateWealth() {
        // Get inventory
        self.gifts = OwnedGift.inventory.filter({ $0.kind == kind })
        
        // Update tableView
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Mes cadeaux"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gifts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (tableView.dequeueReusableCell(withIdentifier: "giftCell", for: indexPath) as! GiftTableViewCell).with(gift: gifts[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get selected gift
        let gift = gifts[indexPath.row]
        
        // Use on mood
        gift.useOnMood()
        
        // And dismiss
        dismiss(animated: true) {
            // Call completion handler
            self.completionHandler(gift.gift)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    @objc func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

}
