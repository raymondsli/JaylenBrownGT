//
//  DetailedSeasonVC.swift
//  JB
//
//  Created by Raymond Li on 7/29/17.
//  Copyright © 2017 Raymond Li. All rights reserved.
//

import UIKit

class DetailedSeasonVC: UIViewController {
    
    var gameInfoString: String!
    var mainStatsString: String!
    var additionalStatsString: String!
    var shootingDetailsString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Season Details"
    }
}
