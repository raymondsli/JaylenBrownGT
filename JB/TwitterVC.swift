//
//  TwitterVC.swift
//  JB
//
//  Created by Raymond Li on 8/21/18.
//  Copyright © 2018 Raymond Li. All rights reserved.
//

import UIKit

class TwitterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func twitterPressed(_ sender: Any) {
        let childTwitter = self.childViewControllers.last as! JBTwitterTimeline
        if childTwitter.tableView.numberOfRows(inSection: 0) > 0 {
            childTwitter.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
