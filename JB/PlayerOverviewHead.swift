//
//  PlayerOverviewHead.swift
//  JB
//
//  Created by Raymond Li on 8/21/18.
//  Copyright © 2018 Raymond Li. All rights reserved.
//

import UIKit

class PlayerOverviewHead: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextGameDate: UILabel!
    @IBOutlet weak var nextGameDetails: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerOverviewHead", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        nextGameDate.adjustsFontSizeToFitWidth = true
        nextGameDetails.adjustsFontSizeToFitWidth = true
    }
    

}
