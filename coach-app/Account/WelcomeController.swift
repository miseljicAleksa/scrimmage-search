//
//  WelcomeController.swift
//  coach-app
//
//  Created by alk msljc on 1/27/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import UIKit


class WelcomeController: AbstractAccountController{
    
    //outlets
    @IBOutlet weak var postGameButton: UIButton!
    @IBOutlet weak var lookingForButtonOutlet: UIButton!
    @IBOutlet weak var scrimmageSearchButtonOutlet: UIButton!
    
    //actions
    @IBAction func lookingForButtonClicked(_ sender: UIButton) {
        let bs = WelcomeControllerPicker()
        print("DA LI OVO RADI TEBROOOOOO???")
        self.present(bs, animated: true)
    }
    
    //@todo
    @IBAction func postGameButtonClicked(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "PostGameController")
        if(self.navigationController == nil)
        {
            print("dada")
            
        }
        self.navigationController?.pushViewController(memberDetailsViewController, animated:true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postGameButton.backgroundColor = UIColor.coachGreen()
        navigationController?.navigationBar.barTintColor = UIColor.coachGreen()
        
        if (UserDefaults.standard.string(forKey: "first_name") != nil){
            let name = UserDefaults.standard.string(forKey: "first_name")!
            addScrimmageNavBar(title: "Hi, \(name)!")
        }else{
            addScrimmageNavBar(title: "Welcome")
        }
        
        registerForPushNotifications()
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    func    registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }
   

}
