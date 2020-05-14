//
//  WelcomeControllerPicker.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/11/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit
import SideMenuSwift



    class WelcomeControllerPicker: AbstractViewController {
        //outlets
        @IBOutlet weak var bottomLine1: UIView!
        @IBOutlet weak var teamsButtonOutlet: UIButton!
        @IBOutlet weak var officialsButtonOutlet: UIButton!
        @IBOutlet weak var coachesButtonOutlet: UIButton!
        @IBOutlet weak var playersButtonOutlet: UIButton!
        @IBOutlet weak var gamesButtonOutlet: UIButton!
        
        //actions
        @IBAction func closeButtonClicked(_ sender: UIButton) {
            self.dismiss(animated: true)
        }
        
        @IBAction func teamsButtonClicked(_ sender: Any) {
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let nextCon = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
            nextCon.modalPresentationStyle = .fullScreen
            nextCon.type = .team
            if let pc = self.presentingViewController as? SideMenuController{
                if let nav = pc.contentViewController as? UINavigationController {
                    nav.pushViewController( nextCon, animated: true)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func officialsButtonClicked(_ sender: Any) {
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let nextCon = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
            nextCon.modalPresentationStyle = .fullScreen
            nextCon.type = .official
            if let pc = self.presentingViewController as? SideMenuController{
                if let nav = pc.contentViewController as? UINavigationController {
                    nav.pushViewController( nextCon, animated: true)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func coachesButtonClicked(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        
        @IBAction func playersButtonClicked(_ sender: Any) {
           let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
                let nextCon = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
                nextCon.modalPresentationStyle = .fullScreen
                nextCon.type = .player
                if let pc = self.presentingViewController as? SideMenuController{
                    if let nav = pc.contentViewController as? UINavigationController {
                        nav.pushViewController( nextCon, animated: true)
                    }
                }
                self.dismiss(animated: true, completion: nil)
            }
        
        @IBAction func gamesButtonClicked(_ sender: Any) {
            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let nextCon = storyBoard.instantiateViewController(withIdentifier: "SearchController") as! SearchController
            nextCon.modalPresentationStyle = .fullScreen
            nextCon.type = .game
            if let pc = self.presentingViewController as? SideMenuController{
                if let nav = pc.contentViewController as? UINavigationController {
                    nav.pushViewController( nextCon, animated: true)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        
        
        var customTransitioningDelegate = AlertTransitioningDelegate()
        
        var delegate : ActionsDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bottomLine1.backgroundColor = UIColor.coachGrey()
            teamsButtonOutlet.backgroundColor = UIColor.coachGreen()
            officialsButtonOutlet.backgroundColor = UIColor.coachGreen()
            coachesButtonOutlet.backgroundColor = UIColor.coachGreen()
            playersButtonOutlet.backgroundColor = UIColor.coachGreen()
            gamesButtonOutlet.backgroundColor = UIColor.coachGreen()
            
        }
        
        
        convenience init() {
            self.init(nibName:nil, bundle:nil)
            configure()
        }
        
        
        func configure() {
            customTransitioningDelegate.height = 520
            customTransitioningDelegate.position = .BOTTOM
            modalPresentationStyle = .custom
            modalTransitionStyle = .coverVertical // use whatever transition you want
            transitioningDelegate = customTransitioningDelegate
        }
        
        
       
        
        }



        

