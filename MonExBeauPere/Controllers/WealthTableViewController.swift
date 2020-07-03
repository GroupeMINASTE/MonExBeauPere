//
//  WealthTableViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 23/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import GameKit

class WealthTableViewController: UITableViewController, GKGameCenterControllerDelegate {
    
    // Data shown in tableView
    var total: UInt64 = 0
    var gifts = [OwnedGift]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation
        navigationItem.title = "Ma richesse"
        
        // Register cells
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.register(GiftTableViewCell.self, forCellReuseIdentifier: "giftCell")
        
        // Update wealth and gifts datas
        updateWealth()
    }
    
    func updateWealth() {
        // Get inventory
        self.gifts = OwnedGift.inventory
        
        // Calculate total
        self.total = gifts.reduce(0, { $0 + UInt64($1.amount) * $1.value })
        
        // Update tableView
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Ma richesse" : "Mes cadeaux"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : gifts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "💶 \(total.euroPrice ?? "0 €")")
            } else if indexPath.row == 1 {
                return (tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell).with(title: "Voir le classement", alignment: .left, handler: openLeaderboard)
            }
        } else if indexPath.section == 1 {
            return (tableView.dequeueReusableCell(withIdentifier: "giftCell", for: indexPath) as! GiftTableViewCell).with(gift: gifts[indexPath.row])
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 44 : 68
    }
    
    func openLeaderboard() {
        // Create a view controller
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        viewController.viewState = .leaderboards
        present(viewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

}
