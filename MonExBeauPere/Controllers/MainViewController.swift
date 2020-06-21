//
//  MainViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import GameKit

class MainViewController: UIViewController, GKGameCenterControllerDelegate {
    
    // Views
    let stackView = UIStackView()
    let label = UILabel()
    let details = UILabel()
    let wealth = UILabel()
    let generate = UIButton()
    let share = UIButton()

    // Load views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar
        title = "Mon ex beau-père"
        navigationItem.rightBarButtonItem = InfoBarButtonItem(target: self, action: #selector(openSettings(_:)))
        
        // Add views
        view.backgroundColor = .background
        view.addSubview(label)
        view.addSubview(details)
        view.addSubview(wealth)
        view.addSubview(stackView)
        
        // Configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -50).isActive = true
        label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .text
        
        // Configure amount
        details.translatesAutoresizingMaskIntoConstraints = false
        details.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
        details.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        details.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        details.font = .systemFont(ofSize: 17)
        details.textAlignment = .center
        details.textColor = .text
        
        // Configure wealth
        wealth.translatesAutoresizingMaskIntoConstraints = false
        wealth.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        wealth.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        wealth.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        wealth.font = .systemFont(ofSize: 17)
        wealth.textAlignment = .center
        wealth.textColor = .text
        wealth.isUserInteractionEnabled = true
        wealth.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openLeaderboard(_:))))
        
        // Configure the stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true
        stackView.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(generate)
        stackView.addArrangedSubview(share)
        
        // Configure generate
        generate.translatesAutoresizingMaskIntoConstraints = false
        generate.widthAnchor.constraint(equalToConstant: 250).isActive = true
        generate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generate.setTitleColor(.white, for: .normal)
        generate.backgroundColor = .systemBlue
        generate.layer.masksToBounds = true
        generate.layer.cornerRadius = 10
        generate.addTarget(self, action: #selector(generateLabel(_:)), for: .touchUpInside)
        
        // Configure share
        share.translatesAutoresizingMaskIntoConstraints = false
        share.widthAnchor.constraint(equalToConstant: 250).isActive = true
        share.heightAnchor.constraint(equalToConstant: 50).isActive = true
        share.setTitle("Partager", for: .normal)
        share.setTitleColor(.white, for: .normal)
        share.backgroundColor = .systemBlue
        share.layer.masksToBounds = true
        share.layer.cornerRadius = 10
        share.addTarget(self, action: #selector(shareToTwitter(_:)), for: .touchUpInside)
        
        // Game center authentification
        authenticatePlayer()
        
        // Update button
        updateGenerateButton()
        
        // Update wealth
        updateWealth()
        
        // Start a timer to update button
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.updateGenerateButton() }
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
            }
        }
    }

    // Handle generate button
    @objc func generateLabel(_ sender: Any) {
        // Get data (preferences)
        let datas = UserDefaults.standard
        
        // Get a random element from library
        guard let element = Gift.library.randomElement() else { return }
        
        // Get count and save the new count
        let count = datas.integer(forKey: "gift_\(element.id)") + 1
        datas.set(count, forKey: "gift_\(element.id)")
        datas.set(Date().timeIntervalSince1970, forKey: "lastTime")
        datas.synchronize()
        
        // Create text
        let text = "Mon ex beau-père m'a offert \(element.name), je ne sais pas quoi dire..."
        let detailsText = "+ \(element.value.euroPrice ?? "0 €")"
        
        // Set text to label
        label.text = text
        details.text = detailsText
        
        // Add a vibration
        if datas.value(forKey: "vibrate") as? Bool ?? true {
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        }
        
        // Update wealth
        updateWealth()
        
        // And generate button
        updateGenerateButton()
    }
    
    func updateWealth() {
        // Store current wealth
        var current: UInt64 = 0
        
        // Get data (preferences)
        let datas = UserDefaults.standard
        
        // Iterate gift
        for gift in Gift.library {
            // Get count for current gift
            let count = datas.integer(forKey: "gift_\(gift.id)")
            
            // Add count times value
            current += UInt64(count) * gift.value
        }
        
        // Update text
        wealth.text = "💶 \(current.euroPrice ?? "0 €")"
        
        // Send to game center
        let score = GKScore(leaderboardIdentifier: "me.nathanfallet.MonExBeauPere.wealth")
        score.value = current > Int64.max ? Int64.max : Int64(current)
        GKScore.report([score]) { error in if let error = error { print(error.localizedDescription) }}
    }
    
    func updateGenerateButton() {
        // Get data (preferences)
        let datas = UserDefaults.standard
        
        // Get last gift time
        let lastTime = datas.double(forKey: "lastTime")
        
        // Get current time
        let currentTime = Date().timeIntervalSince1970
        
        // Calculate next time (hourly)
        let nextTime = lastTime + 60*60
        
        // Get time left before next gift
        let left = Int(nextTime - currentTime)
        
        // If time left
        if left > 0 {
            // Disable button and set text to time left
            generate.isEnabled = false
            generate.setTitle("\(left / 60) min \(left % 60) sec", for: .normal)
        } else {
            // It's ok
            generate.isEnabled = true
            generate.setTitle("Déballer", for: .normal)
        }
    }
    
    @objc func shareToTwitter(_ sender: UIButton) {
        // Get text
        guard let text = label.text, !text.isEmpty else { return }
        
        // Create URL
        let shareString = "https://twitter.com/intent/tweet?text=\(text) #MonExBeauPère"

        // Encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        // Cast to an url
        guard let url = URL(string: escapedShareString) else { return }

        // open in safari
        UIApplication.shared.open(url)
    }
    
    @objc func openSettings(_ sender: UIBarButtonItem) {
        // Open the settings view controller
        navigationController?.pushViewController(SettingsTableViewController(style: .grouped), animated: true)
    }
    
    @objc func openLeaderboard(_ sender: UIGestureRecognizer) {
        // Create a view controller
        let viewController = GKGameCenterViewController()
        viewController.gameCenterDelegate = self
        viewController.viewState = .leaderboards
        present(viewController, animated: true, completion: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Update stack view axis
        stackView.axis = UIDevice.current.orientation.isPortrait ? .vertical : .horizontal
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }

}

