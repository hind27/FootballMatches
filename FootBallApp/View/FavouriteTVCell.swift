//
//  FavouriteTVCell.swift
//  FootBallApp
//
//  Created by hind on 2/23/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit

class FavouriteTVCell: UITableViewCell {

    @IBOutlet weak var teamFav: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
