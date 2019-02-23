//
//  CompetitionTableVC.swift
//  FootBallApp
//
//  Created by hind on 2/22/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit

class CompetitionTableVC: UITableViewController {

    let football = Football.sharedInstance()
    var competion = [Competition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCompetitions()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCompetitions()
        
    }
    
    func getCompetitions()
    {
        football.getCompetitions(){ (competitionArray, error) in
            if let error = error {
                self.alertWithError(error: error)
            } else {
                guard let competitionArray = competitionArray else {
                    return
                }
                self.competion = competitionArray
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }
        }
        
    }
     // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competion.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! CompetitionTVCell
        let competition = competion[indexPath.row]
        cell.CompetitionName?.text = competition.CompetioName
        return cell
    }
  
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let competitionId = competion[indexPath.row].CompetionId
        let competitionName = competion[indexPath.row].CompetioName
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ToListTeam") as! TeamTableVC
        vc.id = competitionId
        vc.competitionName = competitionName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
   private func alertWithError(error: String) {
    
    let alertView = UIAlertController(title:"Error", message: error, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title:"Dismiss", style: .cancel)
    alertView.addAction(cancelAction)
    self.present(alertView, animated: true)
                            
    }

  

}
