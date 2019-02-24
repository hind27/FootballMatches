//
//  MatchTeamVC.swift
//  FootBallApp
//
//  Created by hind on 2/22/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit
import CoreData

class MatchTeamVC : UIViewController ,UITableViewDataSource ,UITableViewDelegate {
 
    //MARK :- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var teamimage: UIImageView!
    
    //MARK :- Variables/constants
    let football = Football.sharedInstance()
    var Matchs = [Match]()
    var TeamId :Int!
    var TeamName : String!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var teamlogo : String!

    
    //MARK :- lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = TeamName
        getteamlogo()
        getTeamMatches()
        tableView.allowsSelection = false
        self.tableView.dataSource = self
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if check(teamId:TeamId)
        {
            favBtn.image = (#imageLiteral(resourceName: "fav"))
            favBtn.tintColor = UIColor.red


        }
        else
        {
            favBtn.image = (#imageLiteral(resourceName: "notfav"))
            favBtn.tintColor = UIColor.gray
        }
    }
    
    //MARK :- Private Methods
    func getTeamMatches()
    {
        football.getTeamMatchs(id:TeamId){(matchsArray, error) in
            if let error = error {
                self.alertWithError(error: error)
            } else {
                guard let matchsArray = matchsArray else {
                    return
                }
                self.Matchs = matchsArray
                print(self.Matchs.count)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }
    
    func getteamlogo()  {
       
        football.getTeamIcon(teamName: TeamName){(teamlogoReturned, error) in
            if let error = error  {
                self.alertWithError(error: error)
            } else {
                if(teamlogoReturned.isEmpty)
                {
                    self.alertWithError(error: "error")
                }
                else
                {
                    self.teamlogo =  teamlogoReturned
                    DispatchQueue.main.async {
                        //self.loadData()
                        let url = URL(string: self.teamlogo)
                        let data = try? Data(contentsOf: url!)
                        self.teamimage.image = UIImage(data: data!)
                        
                    }                }
               
               }
            }
    }
    
    
    
    
    private func alertWithError(error: String) {
        
        let alertView = UIAlertController(title:"Login Error", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Dismiss", style: .cancel)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true)
        
    }
    
   
    @IBAction func SavetomyFavouriteTeam(_ sender: Any) {
        if check(teamId:TeamId)
        {
            deletefavourtTeam( teamId:TeamId)
            favBtn.image = (#imageLiteral(resourceName: "notfav"))
            favBtn.tintColor = UIColor.gray
        }
        else
        {
            addfavourtTeam(teamId: TeamId, teamName: TeamName)
            favBtn.image = (#imageLiteral(resourceName: "fav"))
            favBtn.tintColor = UIColor.red
        }
    
    }
    // Adds a new team to the end of the `FavouriteTeam` array
    func addfavourtTeam(teamId: Int , teamName : String) {
        
        let team = NSEntityDescription.insertNewObject(forEntityName: "FavouriteTeam", into: context) as! FavouriteTeam
        team.setValue(Int16(teamId), forKey: "id")
        team.setValue(teamName, forKey: "teamName")
         team.setValue(teamlogo, forKey: "teamimage")
        try? context.save()
        
        
    }
    func check( teamId:Int ) -> Bool {
        
        let fetchRequest:NSFetchRequest<FavouriteTeam> = FavouriteTeam.fetchRequest()
        
        let predicate = NSPredicate(format:"id == %ld",Int16(teamId))
        fetchRequest.predicate = predicate
        
        do{
            
            let fetchResults = try context.fetch(fetchRequest)
            
            if fetchResults.count != 0 {
                return true
            } else {
                return false
            }
        } catch let error{
            print(error)
        }
        
        return false
    }
    func deletefavourtTeam(teamId:Int)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteTeam")
        
        request.predicate = NSPredicate(format:"id = %ld", TeamId)
        
        let result = try? context.fetch(request)
        let resultData = result as! [NSManagedObject]
        
        for object in resultData {
            context.delete(object)
        }
        
        do {
            try context.save()
            print("TABLEVIEW-EDIT: saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            // add general error handle here
        }
    }
    func getMatchDate(matchDate:String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatterGet.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy HH:mm"
        dateFormatterPrint.timeZone = NSTimeZone.local
        if let date = dateFormatterGet.date(from: matchDate) {
            return(dateFormatterPrint.string(from: date))
        } else {
            print("There was an error decoding the string")
            return matchDate
        }
        
    }
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Matchs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"MatchCell", for: indexPath) as! MatchTVCell
        let Match = Matchs[indexPath.row]
        cell.awayTeam.text = Match.awayteamname
        cell.AwayTeamResult.text = String(Match.awayteamscore)
        cell.homeTeam.text = Match.hometeamname
        cell.homeTeamReuslt.text = String(Match.hometeamscore)
        cell.Status.text = Match.matchStatus
        cell.matchDate.text = getMatchDate(matchDate: Match.matchDate)
        return cell
    }
    
    
}
