//
//  PlayersResultController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/17/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class PlayersResultController: AbstractViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var countOfTeamsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var source:[Player] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        addScrimmageNavBarBack(title: "Available Teams")
        
        tableView.scrollToBottom(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let howManyTeam = source.count
        countOfTeamsLabel.text = "SEARCH RESULTS: " + String(howManyTeam) + " TEAMS"
        countOfTeamsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        self.tableView.reloadData()
    }
     // MARK: - Table view data source
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
                CGFloat {
                    return 130.0
            }
        
            func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }

            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return source.count
            }

            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                //Get Notification object
                let player = source[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerResultViewCell", for: indexPath) as! PlayerResultViewCell
                //Set row fields
                cell.playerName.text = player.player_name
                cell.playerName.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.playerImage.downloadedFrom(link: player.player_image!)
                cell.playerImage.setRounded()
                let playerBirthStringToDate = player.date_of_birth!.toDate()
                let playerBirthDateToString = playerBirthStringToDate.year

                cell.playerBirth.text = "Born: " + playerBirthDateToString
                cell.playerInterest.text = player.interested_in
                

                return cell
            }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //Get Notification object
            let player: Player = source[indexPath.row]
    
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let destController = storyBoard.instantiateViewController(withIdentifier: "PlayerDetailsController") as! PlayerDetailsController
                    destController.player = player
    
            self.navigationController?.pushViewController(destController, animated: true)
    
        }
        
    
        
        

    }
