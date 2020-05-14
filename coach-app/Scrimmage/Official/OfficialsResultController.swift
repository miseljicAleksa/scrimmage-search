//
//  OfficialsResultController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 3/4/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class OfficialsResultController: AbstractViewController, UITableViewDelegate, UITableViewDataSource {
    var source:[Official] = []

    @IBAction func refineSearchClicked(_ sender: Any) {

        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let refine = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
        refine.configure()
        refine.type = .refine
        refine.delegate = self as? PopUpDelegate
        self.present(refine, animated: true)
        
    }
    @IBOutlet weak var refineSearch: UIButton!
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var officialLabelOutlet: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        addScrimmageNavBarBack(title: "Available Officials")
        buttonContainer.layer.cornerRadius = 40
        if #available(iOS 11.0, *) {
            buttonContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        refineSearch.setTitleColor(UIColor.coachGreen(), for: .normal)
        buttonContainer.backgroundColor = UIColor.coachGrey()
        //refineSearch.backgroundColor = UIColor.coachGreen()
    }
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         self.tableView.reloadData()
        let countOfOfficials = String(source.count)
        officialLabelOutlet.text = "SEARCH RESULTS: " + countOfOfficials + " OFFICIALS"
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
                   let official = source[indexPath.row]
                   
                   let cell = tableView.dequeueReusableCell(withIdentifier: "OfficialResultVIewCell", for: indexPath) as! OfficialResultViewCell
                   //Set row fields
                cell.officialNameLabel.text =  official.name
                cell.officialNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                cell.officialImageOutlet.downloadedFrom(link: official.official_image!)
                cell.officialImageOutlet.setRounded()
                cell.officialGameFeeLabel.text = "$" + official.officiating_fee!
                cell.officialCertificationLabel.text = official.sertificate

                return cell
               }
               
           func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              //Get Notification object
               let official: Official = source[indexPath.row]
       
               let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
               let destController = storyBoard.instantiateViewController(withIdentifier: "OfficialsDetailsController") as! OfficialsDetailsController
                       destController.official = official
       
               self.navigationController?.pushViewController(destController, animated: true)
       
           }

}
