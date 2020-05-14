//
//  PlayersResultController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/17/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class GamesResultController: AbstractViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var countOfTeamsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var source:[Game] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        addScrimmageNavBarBack(title: "Available Games")
        
        tableView.scrollToBottom(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let howManyTeam = source.count
        countOfTeamsLabel.text = String(howManyTeam) + " GAMES AVAILABLE"
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
                let game = source[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "GameResultViewCell", for: indexPath) as! GameResultViewCell
                //Set row fields
                cell.gameAge.text = "Age group: " + game.age_group!
                cell.gameTeams.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.gameTeams.text = game.team_one! + " vs. " + game.team_two!
                let gameDateAndTime = game.date_and_time
                let gameDateAndTimeFormated = gameDateAndTime?.toDateTime()
                let gamegame = gameDateAndTimeFormated?.formatted
                cell.gameTime.text = gamegame
                cell.gameImage.setRounded()
                

                return cell
            }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //Get Notification object
            let game: Game = source[indexPath.row]
    
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let destController = storyBoard.instantiateViewController(withIdentifier: "GameDetailsController") as! GameDetailsController
                    destController.game = game
    
            self.navigationController?.pushViewController(destController, animated: true)
    
        }
        
    
        
        

    }
