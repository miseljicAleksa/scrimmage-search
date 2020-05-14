//
//  RefineSearchController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit


class RefineSearchController: AbstractViewController {
    
    var customTransitioningDelegate = TransitioningDelegate()
    var delegate : PopUpDelegate?
       
       @IBAction func refineSearch(_ sender: Any) {
           
           //searchTeams(lon: <#T##String#>, lat: <#T##String#>, home_field_available: <#T##String#>, looking_date: <#T##String#>, flexible_on_date: <#T##String#>, day_period: <#T##String#>, flexible_on_time: <#T##String#>, need_players: <#T##String#>, miles_radius: <#T##String#>)
       }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    convenience init() {
        self.init(nibName:nil, bundle:nil)
        configure()
    }
    
    func configure() {
        customTransitioningDelegate.height = 600
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve // use whatever transition you want
        transitioningDelegate = customTransitioningDelegate
    }
    
    func searchTeams(lon: String, lat: String, home_field_available:String, looking_date:String, flexible_on_date:String, day_period:String, flexible_on_time:String, need_players:String, miles_radius:String){
        
        let dm = DataManager()
        
        dm.searchTeams(lon: lon, lat: lat, home_field_available: home_field_available, looking_date: looking_date, flexible_on_date: flexible_on_date, day_period: day_period, flexible_on_time: flexible_on_time, need_players: need_players, miles_radius: miles_radius, completion: { (json) -> Void in
                
                let status = json["status"]
                let message = json["message"]
                if(status == "success"){
                    var teams:[Team] = []
                    let result = json["result"]
                    
                    for item in result["list"].arrayValue {
                        let team:Team = Team(json: item)
                        teams.append(team)
                    }
                    
                    
                    //Go next
                    DispatchQueue.main.async(execute: {
                        //self.buttonOutlet.stopAnimating()
                        let newController =  self.presentingViewController as! TeamsResultController
                        
                        newController.source = teams
                        
                        self.dismiss(animated: true, completion: nil)
                        
                        
                    })
                }else{
                   
                    DispatchQueue.main.async(execute: {
                        //self.buttonOutlet.stopAnimating()
                        
                            // Display alert message
                            self.alert(msg: "Unable to save, please try later".localized)
                        
                    })
                }
        })
        }

    

}
