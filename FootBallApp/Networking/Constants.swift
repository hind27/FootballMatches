//
//  Constants.swift
//  FootBallApp
//
//  Created by hind on 2/19/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation

struct Constants {
     // MARK: - football
    struct APIComponents {
        static let APIScheme = "https"
        static let APIHost = "api.football-data.org"
        static let APIPath = "/v2"
        
    }
    struct APIMethods {
          static let competitions = "/competitions"
          static let team = "/teams"
        static let plan_key = "plan"
        static let season = "?season="
        static let matches = "/matches"
        static let status = "?status="
        static let plan_value = "TIER_ONE"
    }
     //MARK: API Header Keys
    struct APIHeaderKeys  {
        static let accept = "Accept"
        static let contentType = "Content-Type"
        static let X_Auth_Token = "X-Auth-Token"
    }
    // MARK: API Header Values
    
    struct APIHeaderValues {
        static let X_Auth_Token = "a9a78aadabad4694a4a7222d8b9b4481"
         static let application_json = "application/json"
    }

    /*https://api.football-data.org/v2/competitions/2021/teams*/
    
    struct FootballParameterKeys {
        
        static let competitions = "competitions"
        static let idOfcompteitions = "id"
        static let nameofcompteitions = "name"
        static let nameofCountry = "name"
        
        static let teams = "teams"
        static let TeamIcon  = "crestUrl"
        static let TeamId = "id"
        static let TeamName = "shortName"
        
        static let matches =  "matches"
        static let MatchData = "utcDate"
        static let Matchstatus = "status"
        static let season = "season"
        static let score = "score"
        static let fulltime = "fullTime"
        static let scheduled = "SCHEDULED"
        static let finished = "FINISHED"
        static let hometeam = "homeTeam"
        static let awayteam = "awayTeam"
        static let hometeamName = "name"
        static let awayteamName = "name"
    }
    
    struct FootballParameterValues {
    
        //matches
        static let scheduled = "SCHEDULED"
        static let finished = "FINISHED"
        
    }
}
