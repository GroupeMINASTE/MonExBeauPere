//
//  Mood.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 26/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

class Mood {
    
    // Mood values (references)
    static let values = [
        Mood(0, name: "😡 En colère", max: 0),
        Mood(1, name: "😩 Déprimé", max: 10),
        Mood(2, name: "🥺 Triste", max: 500),
        Mood(3, name: "😐 Neutre", max: 10_000),
        Mood(4, name: "🙂 Content", max: 50_000),
        Mood(5, name: "😊 Heureux", max: 500_000)
    ]
    
    // Get a mood by id
    static func value(for id: Int) -> Mood? {
        return values.first(where: { $0.id == id })
    }
    
    // Get current mood
    static var current: Mood {
        get {
            // Get data (preferences)
            let datas = UserDefaults.standard
            
            // Get mood from datas
            if let moodId = datas.value(forKey: "mood") as? Int, let mood = value(for: moodId) {
                return mood
            }
            
            // Return default mood
            return value(for: 5)!
        }
        set {
            // Get data (preferences)
            let datas = UserDefaults.standard
            
            // Save mood
            datas.set(newValue.id, forKey: "mood")
            datas.synchronize()
        }
    }
    
    // Properties
    let id: Int
    let name: String
    let max: UInt64
    
    // Initializer
    init(_ id: Int, name: String, max: UInt64) {
        self.id = id
        self.name = name
        self.max = max
    }
    
    // Get next mood
    func next(times: Int = 1) -> Mood {
        // Check if there is a next mood
        if let next = Mood.value(for: id + times) {
            return next
        }
        
        // Return self
        return self
    }
    
}
