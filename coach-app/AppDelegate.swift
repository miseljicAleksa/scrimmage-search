//
//  AppDelegate.swift
//  Lagree
//
//  Created by Arsen Leontijevic on 9/2/19.
//  Copyright © 2019 Arsen Leontijevic. All rights reserved.
//

import UIKit
import GoogleSignIn
import SideMenuSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UITextField.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        //UILabel.appearance(whenContainedInInstancesOf: [UIView.self]).textColor = .black
        
        //window?.backgroundColor = UIColor.white
        
        
        
        
        let theViewController = self.window?.rootViewController
        theViewController?.view.backgroundColor = .white
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = "238871066880-hlvr1d0bshn711c175cskufl1ikgvdff.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        
        var first_identifier = "WelcomeController"
        if access_token == nil {
            first_identifier = "SignupController"
        }else{
            //Check if user break up the process of registration, so we can redirect him to that controller
            switch UserDefaults.standard.string(forKey: "profile_type") {
            case "Coach":
                first_identifier = "CoachProfileController"
            case "Official":
                first_identifier = "OfficialProfileController"
            case "Player":
                first_identifier = "PlayerProfileController"
            default:
                first_identifier = "WelcomeController"
            }
            
            //temp
            first_identifier = "WelcomeController"
        }
        
        // Set first and menu controller
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let contentViewController: UIViewController = storyboard.instantiateViewController(withIdentifier: first_identifier)
        let menuViewController: UIViewController = LeftMenuController()
        
        let screenWidth = UIScreen.main.bounds.size.width
        SideMenuController.preferences.basic.menuWidth = screenWidth / 5 * 4
        SideMenuController.preferences.basic.statusBarBehavior = .hideOnMenu
        SideMenuController.preferences.basic.direction = .left
        SideMenuController.preferences.basic.enablePanGesture = true
        let sideMenuController = SideMenuController(contentViewController: UINavigationController(rootViewController: contentViewController), menuViewController: menuViewController)
            window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = sideMenuController
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        return true
    }
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        let dm:DataManager = DataManager()
        DispatchQueue.global(qos: .background).async {
            let access_token = UserDefaults.standard.string(forKey: "access_token")
            if access_token != nil {
                dm.setDeviceToken(deviceToken: token) { (result) in
                    UserDefaults.standard.set(token, forKey: "deviceToken")
                }
            }
        }
        print("Device Token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
        ) {
        
        print("nots received back foreground 0")
        guard let aps = userInfo["aps"] as? [String: AnyObject] else {
            completionHandler(.failed)
            return
        }
        DispatchQueue.main.async(execute: {
            
                print("nots received back foreground 1")
        })
        completionHandler(.newData)
    }
}

