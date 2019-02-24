//
//  TeamModel.swift
//  FootBallApp
//
//  Created by hind on 2/20/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation

class TeamModel
{
   
    var TeamId: Int!
    var TeamName: String!
    var teamIcon:String!
   
    
  
    func setteamName( TeamName: String  ) {
        
        self.TeamName = TeamName
        
    }
    func setteamId(TeamId: Int ) {
        
        self.TeamId = TeamId
        
    }
    func setteamlogo(teamIcon: String ) {
        
        self.teamIcon = teamIcon
        
    }
}
