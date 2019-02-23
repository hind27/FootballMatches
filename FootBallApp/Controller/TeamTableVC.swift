//
//  TeamTableVC.swift
//  FootBallApp
//
//  Created by hind on 2/22/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit

class TeamTableVC: UITableViewController {

    let football = Football.sharedInstance()
    var teams = [TeamModel]()
    var id :Int!
    var competitionName : String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
         getTeams()
         navigationItem.title = competitionName
    }

    func getTeams()
    {
        football.getTeams(id: id){ (teamsArray, error) in
       
            if let error = error {
                self.alertWithError(error: error)
            } else {
                guard let teamsArray = teamsArray else {
                    return
                }
                self.teams = teamsArray
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"teamcell", for: indexPath) as! TeamTVCell
        let team = teams[indexPath.row]
        cell.teamName?.text = team.TeamName
        //let url = URL(string:team.TeamIcon)
        //let data = try? Data(contentsOf: url!)
       // cell.teamImage?.image = UIImage(data:data! as Data)
       // image(UIImage(data:data! as Data)!,withSize: CGSize(width: 30, height: 30))

         return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let TeamId = teams[indexPath.row].TeamId
        let TeamName = teams[indexPath.row].TeamName
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ToTeamMatch") as! MatchTeamVC
       vc.TeamName  = TeamName
        vc.TeamId = TeamId
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    private func alertWithError(error: String) {
        
        let alertView = UIAlertController(title:"Login Error", message: error, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Dismiss", style: .cancel)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true)
        
    }

    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.alwaysOriginal)
    }
    
}
