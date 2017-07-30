//
//  SeasonCell.swift
//  JB
//
//  Created by Raymond Li on 7/29/17.
//  Copyright © 2017 Raymond Li. All rights reserved.
//

import UIKit

class SeasonCell: UITableViewCell {
    
    @IBOutlet weak var seasonInfoLabel: UILabel!
    
    func configureCell(_ seasonInfo: String) {
        seasonInfoLabel.text = seasonInfo
    }
}
