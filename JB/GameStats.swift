//
//  gameStats.swift
//  JB
//
//  Created by Raymond Li on 8/18/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit
class GameStats {
    
    var dateLocation: String
    
    var totalPoints: Int
    var totalRebounds: Int
    var totalAssists: Int
    var totalSteals: Int
    var totalBlocks: Int
    
    var totalShootingFraction: String
    var totalShootingPercentage: Double
    var twoPointShootingFraction: String
    var twoPointShootingPercentage: Double
    var threePointShootingFraction: String
    var threePointShootingPercentage: Double
    
    var freeThrowFraction: String
    var turnovers: Int
    var score: String
    var minutes: Int
    
    init(dl: String, p: Int, r: Int, a: Int, s: Int, b: Int, tSF: String, tSP: Double, tPSF: String, tPSP: Double, thPSF: String, thPSP: Double, fTF: String, turn: Int, scr: String, min: Int) {
        
        dateLocation = dl
        
        totalPoints = p
        totalRebounds = r
        totalAssists = a
        totalSteals = s
        totalBlocks = b
        
        totalShootingFraction = tSF
        totalShootingPercentage = tSP
        twoPointShootingFraction = tPSF
        twoPointShootingPercentage = tPSP
        threePointShootingFraction = thPSF
        threePointShootingPercentage = thPSP
        
        freeThrowFraction = fTF
        turnovers = turn
        score = scr
        minutes = min
    }
    
    init() {
        dateLocation = "1/1/1"
        
        totalPoints = 0
        totalRebounds = 0
        totalAssists = 0
        totalSteals = 0
        totalBlocks = 0
        
        totalShootingFraction = "0"
        totalShootingPercentage = 0
        twoPointShootingFraction = "0"
        twoPointShootingPercentage = 0
        threePointShootingFraction = "0"
        threePointShootingPercentage = 0
        
        freeThrowFraction = "0"
        turnovers = 0
        score = "W: 1-0"
        minutes = 0
    }
}