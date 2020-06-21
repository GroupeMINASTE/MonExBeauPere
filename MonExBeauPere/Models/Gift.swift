//
//  Gift.swift
//  MonExBeauPere
//
//  Created by Nathan FALLET on 20/06/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import Foundation

class Gift {
    
    // Liste des objets pour la génération des phrases
    static let library = [
        Gift(1, name: "un coussin de mie fourré à la délicate viande de bœuf sur son nid de salade", value: 5),
        Gift(2, name: "HiberFile", value: 1_000),
        Gift(3, name: "HiberLink", value: 100),
        Gift(4, name: "un MacBook Pro i7 2018 avec quatre ports thunderbolt 3 gris sidéral", value: 2_699),
        Gift(5, name: "un iPad Pro 2020 avec un scanner LiDAR", value: 899),
        Gift(6, name: "un iPhone 11 Pro 256 GB vert nuit", value: 1_329),
        Gift(7, name: "une Apple Watch", value: 449),
        Gift(8, name: "une télévision Samsung QE55Q75T 2020", value: 1_190),
        Gift(9, name: "un ex beau-père", value: 150_000),
        Gift(10, name: "une nouvelle voiture", value: 13_000),
        Gift(11, name: "un lingot d'or de 500g", value: 26_800),
        Gift(12, name: "une villa en Corse", value: 500_000),
        Gift(13, name: "une villa en Croatie", value: 0),
        Gift(14, name: "une piscine à débordement", value: 10_000),
        Gift(15, name: "Nathan Fallet", value: 100),
        Gift(16, name: "Bruno Paiva", value: 50),
        Gift(17, name: "Cédric Loneux", value: 50),
        Gift(18, name: "Léo Duff", value: 300),
        Gift(19, name: "Tim Cook", value: 300_000),
        Gift(20, name: "PickADish", value: 50),
        Gift(21, name: "le Groupe MINASTE", value: 50_000),
        Gift(22, name: "FMobile", value: 100),
        Gift(23, name: "une soupe à l'oignon", value: 1),
        Gift(24, name: "des pommes de terre sautées", value: 1),
        Gift(25, name: "de la compote de pommes", value: 1),
        Gift(26, name: "un café glacé", value: 2),
        Gift(27, name: "une quiche aux poireaux", value: 4),
        Gift(28, name: "un iPhone SE 64 GB", value: 489),
        Gift(29, name: "une bouteille de Jack Daniels de 70 cl", value: 12),
        Gift(30, name: "un compte Apple Developer pour un an", value: 99),
        Gift(31, name: "un compte Google Play Developer à vie", value: 25),
        Gift(32, name: "un compte Netflix Premium pour un mois", value: 16),
        Gift(33, name: "un compte Spotify Premium pour un mois", value: 10),
        Gift(34, name: "le N°5 de Chanel", value: 99),
        Gift(35, name: "un sac Louis Vuitton", value: 999),
        Gift(36, name: "un collier en or de Dior", value: 499),
        Gift(37, name: "une montre Diesel en acier doré", value: 219),
        Gift(38, name: "un sac à dos GUCCI", value: 2_690)
    ]
    
    // Properties
    let id: Int
    let name: String
    let value: UInt64
    
    // Initializer
    init(_ id: Int, name: String, value: UInt64) {
        self.id = id
        self.name = name
        self.value = value
    }
    
}
