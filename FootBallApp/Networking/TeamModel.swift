//
//  TeamModel.swift
//  FootBallApp
//
//  Created by hind on 2/20/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation

struct TeamModel 
{
   
    let TeamId: Int
    let TeamName: String
   
    
    init(TeamId: Int,  TeamName: String ) {
        self.TeamId = TeamId
        self.TeamName = TeamName
     
    }
}
