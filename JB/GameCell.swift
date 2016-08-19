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
    @IBOutlet weak var gameStatsLabel: UILabel!
    
    func configureCell(gameInfo: String, gameStats: String) {
        gameInfoLabel.text = gameInfo
        gameStatsLabel.text = gameStats
    }
}
