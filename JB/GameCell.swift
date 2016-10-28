//
//  gameCell.swift
//  JB
//
//  Created by Raymond Li on 8/18/16.
//  Copyright © 2016 Raymond Li. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet weak var gameInfoLabel: UILabel!
    @IBOutlet weak var gameMainStatsLabel: UILabel!
    @IBOutlet weak var gameShootingFLabel: UILabel!
    
    func configureCell(_ gameInfo: String, gameMainStats: String, gameShootingF: String) {
        gameInfoLabel.text = gameInfo
        gameMainStatsLabel.text = gameMainStats
        gameShootingFLabel.text = gameShootingF
    }
}
