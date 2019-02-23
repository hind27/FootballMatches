//
//  MatchTVCell.swift
//  FootBallApp
//
//  Created by hind on 2/23/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit

class MatchTVCell: UITableViewCell {

    
    @IBOutlet weak var homeTeam: UILabel!
    
    @IBOutlet weak var awayTeam: UILabel!
    
    @IBOutlet weak var homeTeamReuslt: UILabel!
    
    @IBOutlet weak var AwayTeamResult: UILabel!
    
    @IBOutlet weak var Status: UILabel!
    
    @IBOutlet weak var matchDate: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
