//
//  SettingsTableViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import DonateViewController

class SettingsTableViewController: UITableViewController, DonateViewControllerDelegate {
    
    var sections = [SettingsSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation
        navigationItem.title = "Paramètres"
        
        // Register cells
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        
        // Load content
        sections += [
            SettingsSection(name: "Configuration", elements: [
                SettingsElementSwitch(id: "vibrate", text: "Activer les vibrations", d: true)
            ]),
            SettingsSection(name: "A propos", elements: [
                SettingsElementLabel(id: "copy1", text: "Développé par Nathan Fallet"),
                SettingsElementLabel(id: "copy2", text: "Logo par Maitre"),
                SettingsElementLabel(id: "copy3", text: "© 2020 Groupe MINASTE")
            ]),
            SettingsSection(name: "Autre", elements: [
                SettingsElementButton(id: "video1", text: "Vidéo du développement (partie 1)") {
                    if let url = URL(string: "https://www.youtube.com/watch?v=3h4nqTeTb8c") {
                        UIApplication.shared.open(url)
                    }
                },
                SettingsElementButton(id: "video2", text: "Vidéo du développement (partie 2)") {
                    if let url = URL(string: "https://www.youtube.com/watch?v=VWODYBZqqcU") {
                        UIApplication.shared.open(url)
                    }
                },
                SettingsElementButton(id: "twitter", text: "Twitter du projet") {
                    if let url = URL(string: "https://twitter.com/MonExBeauPere") {
                        UIApplication.shared.open(url)
                    }
                },
                SettingsElementButton(id: "donate", text: "Faire un don") {
                    let controller = DonateViewController()
                    
                    controller.title = "Faire un don"
                    controller.header = "Sélectionnez le montant à donner :"
                    controller.footer = "Ce don va aider notre association à développer ses projets, notamment Extopy."
                    controller.delegate = self
                    
                    controller.add(identifier: "me.nathanfallet.MonExBeauPere.donate1")
                    
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            ])
        ]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = sections[indexPath.section].elements[indexPath.row]
        
        if let e = element as? SettingsElementLabel {
            return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: e.text)
        } else if let e = element as? SettingsElementSwitch {
            let datas = UserDefaults.standard
            var enabled = e.d
            
            if datas.value(forKey: e.id) != nil {
                enabled = datas.bool(forKey: e.id)
            }
            
            return (tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchTableViewCell).with(id: e.id, text: e.text, preference: true, enabled: enabled)
        } else if let e = element as? SettingsElementButton {
            return (tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell).with(title: e.text, alignment: .left, handler: e.handler)
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationSucceed donation: Donation) {
        let alert = UIAlertController(title: "Merci du don !", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Fermer", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationFailed donation: Donation) {
        print("Donation failed.")
    }

}
