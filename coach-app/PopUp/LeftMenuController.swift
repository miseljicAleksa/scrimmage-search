//
//  MenuController.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/12/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit
import SideMenuSwift

 class LeftMenuController: AbstractAccountController {
     
    //outlets
    @IBOutlet weak var homeButtonOutlet: UIButton!
    @IBOutlet var bottomLines: [UIView]!
    @IBOutlet weak var shareThisAppOutlet: UIButton!
    
    @IBOutlet weak var requestClicked: UIButton!
    
    //actions
    @IBAction func homeButtonClicked(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let nextCon = storyBoard.instantiateViewController(withIdentifier: "WelcomeController") as! WelcomeController
        
        //print(NSStringFromClass(self.sideMenuController!.contentViewController.classForCoder))
        
        let navContent = self.sideMenuController!.contentViewController as! UINavigationController
        navContent.pushViewController(nextCon, animated: true)
        
        
        self.sideMenuController?.hideMenu(animated: true, completion: nil)
    }
    @IBAction func rateButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let nextCon = storyBoard.instantiateViewController(withIdentifier: "RateGameController") as! RateGameController
        
        //print(NSStringFromClass(self.sideMenuController!.contentViewController.classForCoder))
        
        let navContent = self.sideMenuController!.contentViewController as! UINavigationController
        navContent.pushViewController(nextCon, animated: true)
        
        
        self.sideMenuController?.hideMenu(animated: true, completion: nil)
    }
    
    @IBAction func followOnFacebook(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: "https://facebook.com")! as URL)

    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        let wcp = WelcomeControllerPicker()
        self.present(wcp, animated: true)
        self.sideMenuController?.hideMenu(animated: true, completion: nil)
    }
    
    @IBAction func postGameClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let nextCon = storyBoard.instantiateViewController(withIdentifier: "PostGameController") as! PostGameController
        
        //print(NSStringFromClass(self.sideMenuController!.contentViewController.classForCoder))
        
        let navContent = self.sideMenuController!.contentViewController as! UINavigationController
        navContent.pushViewController(nextCon, animated: true)
        
        
        self.sideMenuController?.hideMenu(animated: true, completion: nil)
        

    }
    
    @IBAction func exitMenu(_ sender: Any) {
        self.sideMenuController?.hideMenu(animated: true, completion: nil)
    }
    
    @IBAction func shareAppButtonClicked(_ sender: Any) {
            let activityVC = UIActivityViewController(activityItems: ["www.google.com"], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func requestButtonClicked(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let nextCon = storyBoard.instantiateViewController(withIdentifier: "RequestsController") as! RequestsController

        let navContent = self.sideMenuController!.contentViewController as! UINavigationController
        navContent.pushViewController(nextCon, animated: true)


        self.sideMenuController?.hideMenu(animated: true, completion: nil)
    }
    
    @IBAction func logoutClicked(_ sender: UIButton) {
        
        User.logout()
    AbstractViewController.goToController(animationType: .ANIMATE_RIGHT, modifier: "SignupController")
    }
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        //set background color of break lines
        for line in bottomLines {
            line.backgroundColor = UIColor.coachGrey()
        }
        
        //text color of share this app button
        shareThisAppOutlet.setTitleColor(UIColor.coachGreen(), for: .normal)
            
        }
    
    
    

}

