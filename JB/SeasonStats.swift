//
//  SeasonStats.swift
//  JB
//
//  Created by Raymond Li on 7/29/17.
//  Copyright © 2017 Raymond Li. All rights reserved.
//

import UIKit
class SeasonStats {
    
    var type: String
    var team: String
    var label: String
    
    init(type: String = "", team: String = "", label: String = "") {
        self.type = type
        self.team = team
        self.label = label
    }
}
