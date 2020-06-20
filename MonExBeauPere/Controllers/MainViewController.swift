//
//  MainViewController.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // Views
    let label = UILabel()
    let generate = UIButton()
    let share = UIButton()

    // Load views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar
        title = "Mon ex beau-père"
        
        // Add views
        view.addSubview(label)
        view.addSubview(generate)
        view.addSubview(share)
        
        // Configure label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor, constant: -66).isActive = true
        label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        
        // Configure generate
        generate.translatesAutoresizingMaskIntoConstraints = false
        generate.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        generate.widthAnchor.constraint(equalToConstant: 300).isActive = true
        generate.heightAnchor.constraint(equalToConstant: 50).isActive = true
        generate.setTitle("Générer", for: .normal)
        generate.setTitleColor(.white, for: .normal)
        generate.backgroundColor = .systemBlue
        generate.layer.masksToBounds = true
        generate.layer.cornerRadius = 10
        generate.addTarget(self, action: #selector(generateLabel(_:)), for: .touchUpInside)
        
        // Configure share
        share.translatesAutoresizingMaskIntoConstraints = false
        share.topAnchor.constraint(equalTo: generate.bottomAnchor, constant: 16).isActive = true
        share.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -16).isActive = true
        share.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        share.widthAnchor.constraint(equalToConstant: 300).isActive = true
        share.heightAnchor.constraint(equalToConstant: 50).isActive = true
        share.setTitle("Partager", for: .normal)
        share.setTitleColor(.white, for: .normal)
        share.backgroundColor = .systemBlue
        share.layer.masksToBounds = true
        share.layer.cornerRadius = 10
        share.addTarget(self, action: #selector(shareToTwitter(_:)), for: .touchUpInside)
    }

    // Handle generate button
    @objc func generateLabel(_ sender: UIButton) {
        // Get a random element from library
        guard let element = Library.objects.randomElement() else { return }
        
        // Create text
        let text = String(format: "Mon ex beau-père m'a offert %@, je ne sais pas quoi dire... #MonExBeauPère", element)
        
        // Set text to label
        label.text = text
    }
    
    @objc func shareToTwitter(_ sender: UIButton) {
        // Get text
        guard let text = label.text, !text.isEmpty else { return }
        
        // Create URL
        let shareString = "https://twitter.com/intent/tweet?text=\(text)"

        // Encode a space to %20 for example
        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!

        // Cast to an url
        guard let url = URL(string: escapedShareString) else { return }

        // open in safari
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

}

