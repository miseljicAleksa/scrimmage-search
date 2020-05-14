//
//  NotificationsController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit

class NotificationsController: AbstractViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var notificationsHeaderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var source:[Notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        //call api with action getNotification
        getNotifications()
        //navigation bar
        addScrimmageNavBarBack(title: "Notifications")
        }

        // MARK: - Table view data source
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
            CGFloat {
                return 100.0
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
            let not = source[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScrimmageViewCell", for: indexPath) as! ScrimmageViewCell
            //Set row fields
            if not.viewed == "1"{
                cell.notficationImageView.image = UIImage(named: "notfBellViewed")
                cell.notificationMessageLabel.textColor = UIColor.gray
            }else{
                cell.notficationImageView.image = UIImage(named: "notfBellNotViewed")
                cell.notificationMessageLabel.textColor = UIColor.black
                cell.notficationImageView.isHighlighted = false
            }
            cell.notificationMessageLabel.text = not.message
            cell.notificationTimeLabel.text = not.created_on?.toDateTime().timeAgo()
            
            return cell
        }
        
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//       //Get Notification object
//        let team = source[indexPath.row]
//
//        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
//        let destController = storyBoard.instantiateViewController(withIdentifier: "TeamDetailsController") as! TeamDetailsController
//                //destController.team = team
//
//               self.navigationController?.pushViewController(destController, animated: true)
//
//    }
    
    func getNotifications(){
        let dm = DataManager()
        loader.startAnimating()
        //Start background tread
        DispatchQueue.global(qos: .background).async {
            dm.getNotifications(completion: { (json) -> Void in
                let status = json["status"]
                
                //Get back to main tread
                DispatchQueue.main.async { () -> Void in
                    //self.loader.stopAnimating()
                    if(status == "success"){
                        for (_, item) in json["result"]["list"] {
                            let notiffication = Notification(json: item)
                            self.source.append(notiffication)
                        }
                    }else{
                        self.notificationsHeaderLabel.text = "No New Notififcations"
                    }

                    self.loader.stopAnimating()
                    self.tableView.reloadData()
                    let countNotf = self.source.filter{$0.viewed == "0"}.count
                    self.notificationsHeaderLabel.text = "You Have \(countNotf) New Notififcations"
                }
        })
        }
    }
    
    

}
