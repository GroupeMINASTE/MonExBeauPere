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
    let label = UILabel()
    let details = UILabel()
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
        view.addSubview(label)
        view.addSubview(details)
        view.addSubview(stats)
        view.addSubview(buttons)
        
        // Configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -50).isActive = true
        label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        label.font = .systemFont(ofSize: 24)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .text
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(shareToTwitter(_:))))
        
        // Configure amount
        details.translatesAutoresizingMaskIntoConstraints = false
        details.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
        details.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        details.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        details.font = .systemFont(ofSize: 17)
        details.textAlignment = .center
        details.textColor = .text
        
        // Configure the stats stack view
        stats.translatesAutoresizingMaskIntoConstraints = false
        stats.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 16).isActive = true
        stats.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        stats.spacing = 4
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
        generate.addTarget(self, action: #selector(generateLabel(_:)), for: .touchUpInside)
        
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
        
        // Update button
        updateGenerateButton()
        
        // Update stats
        updateStats()
        
        // Start a timer to update button
        let _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in self.updateGenerateButton() }
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
    @objc func generateLabel(_ sender: Any) {
        // Get data (preferences)
        let datas = UserDefaults.standard
        
        // Get a random element from library
        guard let element = Gift.unwrap() else { return }
        
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
        
        // Update stats
        updateStats()
        
        // And generate button
        updateGenerateButton()
    }
    
    func updateStats() {
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
        
        // Update wealth text
        wealth.text = "💶 \(current.euroPrice ?? "0 €")"
        
        // Update mood text
        mood.text = Mood.current.name
        
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
        
        // Calculate next time (every 10 minutes)
        let nextTime = lastTime + 600
        
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
    
    @objc func shareToTwitter(_ sender: UIGestureRecognizer) {
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

