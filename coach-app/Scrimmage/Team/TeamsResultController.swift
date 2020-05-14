//
//  TeamsResultController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/25/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class TeamsResultController: AbstractViewController, UITableViewDelegate, PopUpDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    var source:[Team] = []
    
    @IBOutlet weak var countOfTeamsLabel: UILabel!
    @IBOutlet weak var refineSearchButtonOutlet: UIButton!
    @IBAction func refineSearchButtonClicked(_ sender: Any) {

        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let refine = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
        refine.configure()
        refine.type = .refine
        refine.delegate = self
        self.present(refine, animated: true)
    }
    
    func nextButtonClicked() {
        //
    }
    
    
    
    @IBOutlet var buttonOutletCollection: [UIButton]!
    @IBOutlet weak var buttonContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        addScrimmageNavBarBack(title: "Available Teams")
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        refineSearchButtonOutlet.setTitleColor(UIColor.coachGreen(), for: .normal)
        
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
                let team = source[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ScrimmageViewCell", for: indexPath) as! TeamResultViewCell
                //Set row fields
                cell.teamName.text = team.team_name! + " (" + team.age_group! + ")"
                cell.teamName.font = UIFont.boldSystemFont(ofSize: 17.0)
                let teamDistance = team.distance
                cell.teamDistance.text = teamDistance!.stringWithoutDecimal + " miles"
                cell.teamImage.downloadedFrom(link: team.team_image!)
                cell.teamImage.setRounded()
                let teamRating = team.team_rate?.toOneDecimal()
                cell.teamRating.text = teamRating
                cell.teamZipCode.text = team.team_zip_code ?? " "

                return cell
            }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //Get Notification object
            let team: Team = source[indexPath.row]
    
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let destController = storyBoard.instantiateViewController(withIdentifier: "TeamDetailsController") as! TeamDetailsController
                    destController.team = team
    
            self.navigationController?.pushViewController(destController, animated: true)
    
        }
        
    
        
        

    }

