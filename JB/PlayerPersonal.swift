//
//  PlayerPersonal.swift
//  JB
//
//  Created by Raymond Li on 8/21/18.
//  Copyright © 2018 Raymond Li. All rights reserved.
//

import UIKit

class PlayerPersonal: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var draftPick: UILabel!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var heightWeight: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("PlayerPersonal", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
