//
//  MainViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import GameKit

class MainViewController: UIViewController {
    
    // Views
    let stats = UIStackView()
    let buttons = UIStackView()
    let avatar = UIImageView()
    let name = UILabel()
    let wealth = UILabel()
    let mood = UILabel()
    let generate = UIButton()
    let detailedWealth = UIButton()

    // Load views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar
        title = "Mon ex beau-père"
        navigationItem.rightBarButtonItem = InfoBarButtonItem(target: self, action: #selector(openSettings(_:)))
        
        // Add views
        view.backgroundColor = .background
        view.addSubview(avatar)
        view.addSubview(name)
        view.addSubview(stats)
        view.addSubview(buttons)
        
        // Configure avatar
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        avatar.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -50).isActive = true
        avatar.widthAnchor.constraint(equalToConstant: 100).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 50
        avatar.image = UIImage(named: "Logo")
        avatar.isUserInteractionEnabled = true
        avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takeCare(_:))))
        
        // Configure name
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 8).isActive = true
        name.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        name.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        name.font = .systemFont(ofSize: 17)
        name.textAlignment = .center
        name.numberOfLines = 0
        name.textColor = .text
        name.text = "Mon ex beau-père\n(Cliquez pour s'en occuper)"
        name.isUserInteractionEnabled = true
        name.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(takeCare(_:))))
        
        // Configure the stats stack view
        stats.translatesAutoresizingMaskIntoConstraints = false
        stats.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        stats.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        stats.spacing = 8
        stats.distribution = .fillEqually
        stats.addArrangedSubview(wealth)
        stats.addArrangedSubview(mood)
        
        // Configure wealth
        wealth.translatesAutoresizingMaskIntoConstraints = false
        wealth.font = .systemFont(ofSize: 17)
        wealth.textAlignment = .center
        wealth.textColor = .text
        
        // Configure mood
        mood.translatesAutoresizingMaskIntoConstraints = false
        mood.font = .systemFont(ofSize: 17)
        mood.textAlignment = .center
        mood.textColor = .text
        
        // Configure the buttons stack view
        buttons.translatesAutoresizingMaskIntoConstraints = false
        buttons.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        buttons.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true
        buttons.spacing = 16
        buttons.distribution = .fillEqually
        buttons.addArrangedSubview(generate)
        buttons.addArrangedSubview(detailedWealth)
        
        // Configure generate
        generate.translatesAutoresizingMaskIntoConstraints = false
        generate.widthAnchor.constraint(equalToConstant: 250).isActive = true
        generate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generate.setTitleColor(.white, for: .normal)
        generate.backgroundColor = .systemBlue
        generate.layer.masksToBounds = true
        generate.layer.cornerRadius = 10
        generate.setTitle("Déballer", for: .normal)
        generate.addTarget(self, action: #selector(unwrap(_:)), for: .touchUpInside)
        
        // Configure detailedWealth
        detailedWealth.translatesAutoresizingMaskIntoConstraints = false
        detailedWealth.widthAnchor.constraint(equalToConstant: 250).isActive = true
        detailedWealth.heightAnchor.constraint(equalToConstant: 50).isActive = true
        detailedWealth.setTitle("Ma richesse", for: .normal)
        detailedWealth.setTitleColor(.white, for: .normal)
        detailedWealth.backgroundColor = .systemBlue
        detailedWealth.layer.masksToBounds = true
        detailedWealth.layer.cornerRadius = 10
        detailedWealth.addTarget(self, action: #selector(openDetailedWealth(_:)), for: .touchUpInside)
        
        // Game center authentification
        authenticatePlayer()
        
        // Update stats
        updateStats()
    }
    
    // Update axis when view is shown
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateStackViewAxis()
    }
    
    // Update stack view axis when needed
    func updateStackViewAxis() {
        stats.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
        buttons.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
    }
    
    // Authenticate player
    func authenticatePlayer() {
        // Get local player
        let localPlayer = GKLocalPlayer.local
        
        // Set authentification handler
        localPlayer.authenticateHandler = { viewController, error in
            // Check if a view controller should be shown
            if let viewController = viewController {
                self.present(viewController, animated: true, completion: nil)
            }
            
            // Check if player is authenticated
            else if localPlayer.isAuthenticated {
                // Load leaderboards
                GKLeaderboard.load()
                
                // Update stats
                self.updateStats()
            }
        }
    }

    // Handle generate button
    @objc func unwrap(_ sender: Any) {
        // Get data (preferences)
        let datas = UserDefaults.standard
        
        // Get a random element from library
        if let element = Gift.unwrap() {
            // Create text
            let text = "Mon ex beau-père m'a offert \(element.name), je ne sais pas quoi dire..."
            let detailsText = "+ \(element.value.euroPrice ?? "0 €")"
            
            // Create an alert
            let alert = UIAlertController(title: text, message: detailsText, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Partager", style: .default) { _ in
                // Create URL
                let shareString = "https://twitter.com/intent/tweet?text=\(text) #MonExBeauPère"

                // Encode a space to %20 for example
                let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

                // Cast to an url
                guard let url = URL(string: escapedShareString) else { return }

                // open in safari
                UIApplication.shared.open(url)
            })
            alert.addAction(UIAlertAction(title: "Fermer", style: .cancel, handler: nil))
            
            // And show it
            present(alert, animated: true, completion: nil)
            
            // Add a vibration
            if datas.value(forKey: "vibrate") as? Bool ?? true {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            }
            
            // Update stats
            updateStats()
        } else {
            // Create an alert
            let alert = UIAlertController(title: "Mon ex beau-père est de mauvaise humeur", message: "Occupez vous un peu de lui", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "D'accord", style: .cancel, handler: nil))
            
            // And show it
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func takeCare(_ sender: UIGestureRecognizer) {
        // Create an alert with actions to take care
        let alert = UIAlertController(title: "M'occuper de mon ex beau-père", message: "Que voulez vous faire ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Lui offrir à manger", style: .default, handler: { _ in
            self.takeCare(with: .food)
        }))
        alert.addAction(UIAlertAction(title: "Lui trouver un copain", style: .default, handler: { _ in
            self.takeCare(with: .person)
        }))
        alert.addAction(UIAlertAction(title: "Lui offrir un divertissement", style: .default, handler: { _ in
            self.takeCare(with: .entertainment)
        }))
        alert.addAction(UIAlertAction(title: "Ne rien faire", style: .cancel, handler: nil))
        
        // Show this alert
        present(alert, animated: true, completion: nil)
    }
    
    func takeCare(with kind: Kind) {
        // Create the controller
        let controller = TakeCareTableViewController(kind: kind) { gift in
            // Update status
            self.updateStats()
            
            // Create confirmation message
            let message = "Il \(kind.verb) avec \(gift.name) !"
            
            // Create an alert
            let alert = UIAlertController(title: "Mon ex beau-père est de meilleur humeur", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "D'accord", style: .cancel, handler: nil))
            
            // And show it
            self.present(alert, animated: true, completion: nil)
        }
        
        // Present it
        present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
    }
    
    func updateStats() {
        // Calculate wealth
        let current = OwnedGift.inventory.reduce(0, { $0 + UInt64($1.amount) * $1.value })
        
        // Update wealth text
        wealth.text = "💶 \(current.euroPrice ?? "0 €")"
        
        // Update mood text
        mood.text = Mood.current.name
        
        // Send to game center
        let score = GKScore(leaderboardIdentifier: "me.nathanfallet.MonExBeauPere.wealth")
        score.value = current > Int64.max ? Int64.max : Int64(current)
        GKScore.report([score]) { error in if let error = error { print(error.localizedDescription) }}
    }
    
    @objc func openDetailedWealth(_ sender: UIButton) {
        // Open the details view controller
        navigationController?.pushViewController(WealthTableViewController(style: .grouped), animated: true)
    }
    
    @objc func openSettings(_ sender: UIBarButtonItem) {
        // Open the settings view controller
        navigationController?.pushViewController(SettingsTableViewController(style: .grouped), animated: true)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        updateStackViewAxis()
    }

}

