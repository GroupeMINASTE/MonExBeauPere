//
//  SettingsTableViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
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
                SettingsElementButton(id: "video1", text: "Vidéo du développement (partie 1)") { () in
                    if let url = URL(string: "https://www.youtube.com/watch?v=3h4nqTeTb8c") {
                        UIApplication.shared.open(url)
                    }
                },
                SettingsElementButton(id: "video2", text: "Vidéo du développement (partie 2)") { () in
                    if let url = URL(string: "https://www.youtube.com/watch?v=VWODYBZqqcU") {
                        UIApplication.shared.open(url)
                    }
                },
                SettingsElementButton(id: "moreApps", text: "Groupe MINASTE") { () in
                    if let url = URL(string: "https://itunes.apple.com/us/developer/groupe-minaste/id1378426984") {
                        UIApplication.shared.open(url)
                    }
                }
            ])
        ]
    }
    
    @objc func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

}
