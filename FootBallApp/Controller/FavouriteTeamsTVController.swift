//
//  FavouriteTeamsTVController.swift
//  FootBallApp
//
//  Created by hind on 2/23/19.
//  Copyright © 2019 hind. All rights reserved.
//

import UIKit
import CoreData

class FavouriteTeamsTVController: UITableViewController {

    
    var Teams : [FavouriteTeam] = []
    
    var fetchedResultsController:NSFetchedResultsController<FavouriteTeam>!
    //var dataController: DataController!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupFetchedResultsController()
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupFetchedResultsController()
    }
    // MARK:  Core Data setup - Fetched Results Controller
    fileprivate func setupFetchedResultsController() {
        let fetchRequest:NSFetchRequest<FavouriteTeam> = FavouriteTeam.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "teamName", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do {
           // try fetchedResultsController.performFetch()
            try
                Teams = context.fetch(fetchRequest)
             DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:NSLocalizedString("Ok", comment: "Default Action"), style: .default))
                alert.message = "The fetch could not be performed: \(error.localizedDescription)"
                self.present(alert, animated: true, completion: nil)
            }
        }}


    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       return Teams.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! FavouriteTVCell
        
       let team = Teams[indexPath.row]
        cell.teamFav?.text = team.teamName
        

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let TeamId = Teams[indexPath.row].id
        let TeamName = Teams[indexPath.row].teamName
        let vc = self.storyboard?.instantiateViewController(withIdentifier:"ToTeamMatch") as! MatchTeamVC
        vc.TeamName  = TeamName
        vc.TeamId = Int(TeamId)
        self.navigationController?.pushViewController(vc, animated: true)
    }

   
}
