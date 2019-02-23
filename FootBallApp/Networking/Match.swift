//
//  Matchs.swift
//  FootBallApp
//
//  Created by hind on 2/21/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation
class Match {
    

    var matchDate: String!
    var matchStatus: String!
    
    var hometeamscore : Int!
    var awayteamscore : Int!
    
    var hometeamname : String!
    var awayteamname : String!
   
  
    
    func setMatchStatus(matchStatus: String ) {
        
        self.matchStatus = matchStatus

    }
    func setMatchdate(matchDate : String)
    {
          self.matchDate = matchDate
    }
    
    func setAwayTeam(awayteamscore : Int)
    {
        self.awayteamscore = awayteamscore
    }
    
    func setHometeam( hometeamscore :Int) {
       
        self.hometeamscore = hometeamscore
    
    }
    func setAwayTeamName(awayteamname : String)
    {
        self.awayteamname = awayteamname
    }
    
    func setHometeamName( hometeamname :String) {
        
        self.hometeamname = hometeamname
        
    }
}
