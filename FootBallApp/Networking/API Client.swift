//
//  API Client.swift
//  FootBallApp
//
//  Created by hind on 2/20/19.
//  Copyright © 2019 hind. All rights reserved.
//

import Foundation

class Football {
//MARK: Properties
let sessionObject: Session


//MARK: Singleton Class
private static var sharedManager = Football()
class func sharedInstance() -> Football{
    return sharedManager
}

//MARK: Init Method

    init() {
         let apiUrlData =  APIUrlData(scheme: Constants.APIComponents.APIScheme, host: Constants.APIComponents.APIHost, path: Constants.APIComponents.APIPath)
          sessionObject = Session(apiData: apiUrlData)
      }
    
    
    public func getCompetitions( responseClosure: @escaping (_ array:[Competition]? , _ error: String?) -> Void) {

        let competitionsURL = sessionObject.urlForRequest(apiMethod: Constants.APIMethods.competitions,
                                                          parameters: [
                                                            Constants.APIMethods.plan_key: Constants.APIMethods.plan_value
                                                                as AnyObject])
        
     
        print(competitionsURL)
        sessionObject.makeRequest(Url:competitionsURL) { (data, error) in
            // Check For Errors
            guard error == nil else {
                responseClosure(nil, error)
                return
            }
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                
                print("Could not parse the data as JSON")
                responseClosure(nil , error as? String)
                return
            }
        
            /* GUARD: Is "competitions" key in our result? */
            guard let CompetitionsArray = parsedResult[Constants.FootballParameterKeys.competitions] as? [[String:AnyObject]] else {
               print("Cannot find keys '\(Constants.FootballParameterKeys.competitions)' in \(parsedResult)")
                responseClosure(nil, "Cannot find keys '\(Constants.FootballParameterKeys.competitions)' in \(parsedResult)")
                return
            }
            if CompetitionsArray.count == 0 {
                print("No Competitions Found. try Again.")
                responseClosure(nil, error)
                return
            } else {
                var competitions : [Competition] = []
                for index in 0...CompetitionsArray.count-1 {
                    
                    let competitionDictionary = CompetitionsArray[index] as [String: AnyObject]
            
                    //url_n
                    /* GUARD: Does our photo have a key for 'url_n'? */
                    if let comptetionId = competitionDictionary[Constants.FootballParameterKeys.idOfcompteitions]
                        ,let comptetionName = competitionDictionary[Constants.FootballParameterKeys.nameofcompteitions]{
                        
                        let comptetionId = comptetionId as? Int
                        let comptetionName = comptetionName as? String
                        
                        competitions.append(Competition(CompetionId: comptetionId!, CompetioName: comptetionName!))
                      
                    } }
                responseClosure(competitions, nil)

                }
        }
    }
     func getTeams( id:Int ,responseClosure: @escaping (_ array:[TeamModel]? , _ error: String?) -> Void){
        
        
        let TeamsURL = sessionObject.urlForRequest(apiMethod: Constants.APIMethods.competitions, pathExtension: "/"+String(id), pathExtensionplas:Constants.APIMethods.team )
        print(TeamsURL)
        sessionObject.makeRequest(Url:TeamsURL) { (data, error) in
            // Check For Errors
            guard error == nil else {
                responseClosure(nil, error)
                return
            }
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON")
                responseClosure(nil , error as? String)
                return
            }
            guard let teamsArray = parsedResult[Constants.FootballParameterKeys.teams] as? [[String:AnyObject]] else {
                print("Cannot find keys '\(Constants.FootballParameterKeys.matches)' in \(parsedResult)")
                responseClosure(nil, "Cannot find keys '\(Constants.FootballParameterKeys.matches)' in \(parsedResult)")
                return
            }
            var teams : [TeamModel] = []
            for index in 0...teamsArray.count-1 {
                let team = TeamModel()
                let teamDictionary = teamsArray[index] as [String: AnyObject]
                if let teamId = teamDictionary[Constants.FootballParameterKeys.TeamId],let teamName = teamDictionary[Constants.FootballParameterKeys.TeamName]
                {
                    let teamId = teamId as! Int
                    let teamName = teamName as! String
                    team.setteamId(TeamId: teamId)
                    team.setteamName(TeamName: teamName)
                    teams.append(team)
                }
               
            }
           // print(teams)
            responseClosure(teams, nil)
        }}

    
 func getTeamMatchs( id:Int ,responseClosure: @escaping (_ array:[Match]? , _ error: String?) -> Void) {
 
      print(id)
        let TeamMatchsURL = sessionObject.urlForRequest(apiMethod: Constants.APIMethods.team, pathExtension: "/"+String(id), pathExtensionplas:Constants.APIMethods.matches )
         sessionObject.makeRequest(Url:TeamMatchsURL) { (data, error) in
          // Check For Errors
           guard error == nil else {
                  responseClosure(nil, error)
                   return
                   }
          // parse the data
           let parsedResult: [String:AnyObject]!
               do {
                parsedResult = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [String:AnyObject]
                } catch {
                           print("Could not parse the data as JSON")
                            responseClosure(nil , error as? String)
                     return
                   }
            guard let matchesArray = parsedResult[Constants.FootballParameterKeys.matches] as? [[String:AnyObject]] else {
                print("Cannot find keys '\(Constants.FootballParameterKeys.matches)' in \(parsedResult)")
                responseClosure(nil, "Cannot find keys '\(Constants.FootballParameterKeys.matches)' in \(parsedResult)")
                return
            }
          var matches : [Match] = []
            if (matchesArray.count>0)
            {
                for index in 0...matchesArray.count-1 {
                    let match = Match()
                    
                    let matchDictionary = matchesArray[index] as [String: AnyObject]
                   
                        if let utcData = matchDictionary[Constants.FootballParameterKeys.MatchData],let status = matchDictionary[Constants.FootballParameterKeys.Matchstatus]{
                            
                            let utcData = utcData as? String
                            let status = status as? String
                            
                            match.setMatchdate(matchDate: utcData!)
                            match.setMatchStatus(matchStatus: status!)
                            
                        }
                     
                    if let scoreDictionary = matchDictionary[Constants.FootballParameterKeys.score] as? [String: AnyObject]
                    {
                        if let status = matchDictionary[Constants.FootballParameterKeys.Matchstatus] as? String,status == Constants.FootballParameterValues.finished {
                            
                            if let fulltimeDictionary = scoreDictionary[Constants.FootballParameterKeys.fulltime] as? [String: AnyObject]
                            {
                                if let hometeamResult = fulltimeDictionary[Constants.FootballParameterKeys.hometeam] ,let awayteamResult = fulltimeDictionary[Constants.FootballParameterKeys.awayteam]{
                                    
                                    let hometeamResult = hometeamResult as? Int
                                    let awayteamResult = awayteamResult as? Int
                                    match.setHometeam(hometeamscore: hometeamResult!)
                                    match.setAwayTeam(awayteamscore: awayteamResult!)
                                   
                                }
                            }
                        }else{
                            let hometeamResult = 0
                            let awayteamResult = 0
                            match.setHometeam(hometeamscore: hometeamResult)
                            match.setAwayTeam(awayteamscore: awayteamResult)
                        }}
                    if let homeTeamDictionary = matchDictionary[Constants.FootballParameterKeys.hometeam] as? [String: AnyObject]
                    {
                        if let hometeamname = homeTeamDictionary[Constants.FootballParameterKeys.hometeamName]
                        {
                            let hometeamname = hometeamname as? String
                            match.setHometeamName(hometeamname: hometeamname!)
                        }}
                    if let homeTeamDictionary = matchDictionary[Constants.FootballParameterKeys.awayteam] as? [String: AnyObject]
                    {
                        if let Awayteamname = homeTeamDictionary[Constants.FootballParameterKeys.awayteamName]
                        {
                            let Awayteamname = Awayteamname as? String
                            match.setAwayTeamName(awayteamname: Awayteamname!)
                        }}
                    matches.append(match)
                    
                }
                
            }
         
          responseClosure(matches, nil)
    }}
    func getTeamIcon( teamName :String ,responseClosure: @escaping (_ imageUrlString: String, _ error: String?) -> Void){
    // create session and request
        var  components = URLComponents()
        components.scheme = Constants.APIComponents.APIScheme
        components.host =  "thesportsdb.com"
        components.path = "/api/v1/json/1/searchteams.php"
    
        let parameters = ["t": teamName as AnyObject]
         components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
       
        let tempurl = components.string
        print(tempurl)
        
       //let url = URL(string:link)
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            // if an error occurs, print it and re-enable the UI
            func displayError(_ error: String) {
                print(error)
                responseClosure("", error)
                
            }
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                ///iphone not connected
                responseClosure("", "check network connection")
                displayError("check network connection")
                return
            }
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                responseClosure("", error as? String)
                displayError("Your request returned a status code other than 2xx!")
                return
            }
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                displayError("No data was returned by the request!")
                responseClosure("","No data was returned by the request!")
                return
            }
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
            } catch {
                
                displayError("Could not parse the data as JSON: '\(data)'")
                responseClosure("", "Could not parse the data as JSON: '\(data)'")
                return
            }
            /* GUARD: Is "photos" key in our result? */
            guard let TeamArray = parsedResult["teams"] as? [[String:AnyObject]] else {
                displayError("Cannot find keys '\("0")' in \(parsedResult)")
                responseClosure("", "Cannot find keys '\("0")' in \(parsedResult)")
                return
            }
              let TeamDictionary = TeamArray[0] as [String: AnyObject]
            if let teamicon = TeamDictionary["strTeamBadge"]{
                let teamicon = teamicon as! String
                responseClosure(teamicon, nil)

             }
      
        }
       task.resume()
    }
}
