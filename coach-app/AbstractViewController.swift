import UIKit
class AbstractViewController: UIViewController, UITextFieldDelegate {
    
    
    var vc:UIViewController? = nil
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        super.viewDidLoad()
    }
    
    
    //Open menu
    @objc func revealMenu()
    {
        print("revealMenu")
        self.sideMenuController?.revealMenu()
    }
    

    @objc func goToControllerOnCLick(modifier:String){
        AbstractViewController.goToController(modifier: modifier)
    }
    
    //Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //push to scrimmage storyboard
    func pushControllerToScrimmage(id: String)
    {
        let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
        let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: id)

        if(self.navigationController == nil)
        {
            print("self.navigationController == nil")

        }

        self.navigationController?.pushViewController(memberDetailsViewController, animated: true)
        
        
        
        
                
    }
    
    func pushController(id: String)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: id)
        if(self.navigationController == nil)
        {
            print("dada")
            
        }
        self.navigationController?.pushViewController(memberDetailsViewController, animated:true)
    }
    
    func popupController(id: String)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: id)
        popUpVC.modalTransitionStyle = .coverVertical
        popUpVC.modalPresentationStyle = .fullScreen
        self.present(popUpVC, animated: true, completion: nil)
    }
    
    func addScrimmageNavBar(title: String){
        //Add left nav bar item
       
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(revealMenu), imageName: "hamburgerWhite")
        
       
        
        //Right nav bar items
        let r1 = UIBarButtonItem.menuButton(self, action: #selector(presentSettings), imageName: "useruser")
        let r2 = UIBarButtonItem.menuButton(self, action: #selector(presentSettings), imageName: "bellbell")
        
        //Add right nav bar items
        navigationItem.setRightBarButtonItems([r1,r2], animated: true)
        
        //Add title and color
        let userDef = UserDefaults.standard
        let name = userDef.string(forKey: "first_name")
        self.navigationItem.title = title
        
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.coachGreen()
    }
    
    //navBar with back button
    func addScrimmageNavBarBack(title: String=" "){
        //Add left nav bar item
        navigationItem.leftBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(goBack), imageName: "back-arrow")
         
        
         
         //Right nav bar items
         let r1 = UIBarButtonItem.menuButton(self, action: #selector(pushToUserProfile), imageName: "useruser")
         let r2 = UIBarButtonItem.menuButton(self, action: #selector(presentSettings), imageName: "bellbell")
         
         //Add right nav bar items
         navigationItem.setRightBarButtonItems([r1,r2], animated: true)
         
         //Add title and color
         let userDef = UserDefaults.standard
         let name = userDef.string(forKey: "first_name")
         self.navigationItem.title = title
         
         
         self.navigationController?.navigationBar.tintColor = UIColor.white
         self.navigationController?.navigationBar.barTintColor = UIColor.coachGreen()

        
    }
    
    

    
    static func goToController(animationType:AnimationType = .ANIMATE_LEFT, modifier: String, menu:Bool = false) {
        DispatchQueue.main.async(execute: {
            
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            window.showViewControllerWith(withIdentifier: modifier, usingAnimation: animationType, menu: menu)
            
            
        })
        
    }
    


    
    func addCustomProfileBar(title: String, back: String = "")
    {
        //View
        let myView = UIView(frame: CGRect(x: 0, y: 30, width:view.frame.maxX, height: 30))
        myView.backgroundColor = UIColor.coachGreen()
        
        
        //Title
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = title
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        label.center = myView.center
        label.center = CGPoint(x: label.center.x, y: label.center.y - 30 )
        myView.addSubview(label)
        label.textAlignment = .center
        
        
        
        //Back button
        let image = UIImage(named: "back") as UIImage?
        let button = MyButton(type: UIButton.ButtonType.custom) as MyButton
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setImage(image, for: .normal)
        button.backController = back
        button.addTarget(self, action: #selector(backTouched(sender:)), for:.touchUpInside)
        myView.addSubview(button)
        
        
        //cancel
        let cancel = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 30))
        
        cancel.frame.origin.y = 0
        cancel.frame.origin.x = self.view.frame.width - cancel.frame.width
        
        cancel.text = "CANCEL"
        cancel.font = UIFont.boldSystemFont(ofSize: 12.0)
        cancel.textColor = UIColor.lightGray
        cancel.textAlignment = .center
        myView.addSubview(cancel)
        

//Back button
        let buyCreddits = MyButton(type: UIButton.ButtonType.custom) as MyButton
       button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
       button.setImage(image, for: .normal)
       button.backController = back
       button.addTarget(self, action: #selector(backTouched(sender:)), for:.touchUpInside)
       myView.addSubview(button)

        
        
        
        self.view.addSubview(myView)
    }
    
    @objc func presentSettings()
       {
            print(123)
            pushControllerToScrimmage(id: "NotificationsController")
       }
    
    @objc func pushToUserProfile()
    {
         
         pushControllerToScrimmage(id: "UserProfileController")
    }
       
    
    @objc func backTouched (sender: MyButton)
    {
        if sender.backController != "" {
            
            
            DispatchQueue.main.async(execute: {
                guard let window = UIApplication.shared.keyWindow else {
                    return
                }
                window.showViewControllerWith(withIdentifier: sender.backController!, usingAnimation: .ANIMATE_RIGHT, menu: false)
            })
        }
    }
    
    func displayAlertMessage(userMessage:String) {
        
        let textFieldAlert = UIAlertController(title: "Alert".localized, message: userMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok".localized, style: .default, handler: nil)
        
        textFieldAlert.addAction(okAction)
        
        self.present(textFieldAlert, animated: true, completion: nil)
        
    }
    
    func alert(msg: String) {
        
        let transitionDelegate = AlertTransitioningDelegate()
        vc = UIViewController()
        vc!.modalPresentationStyle = .custom
        vc!.modalTransitionStyle = .coverVertical // use whatever transition you want
        vc!.transitioningDelegate = transitionDelegate
        
        //let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 100))
        vc!.view.backgroundColor = UIColor.white
        //vc!.view = view
        vc!.view.setBorder()
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.size.width-20, height: 30))
        
        label.frame.origin.y = 10
        label.frame.origin.x = 10
        
        label.text = msg
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.center.x = self.view.center.x - 5
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        vc!.view.addSubview(label)
        
        
        let okButton = UIButton(type: UIButton.ButtonType.custom)
        okButton.frame = CGRect(x: 0, y: 70, width: UIScreen.main.bounds.size.width - 10, height: 70)
        okButton.setTitle("OK", for: .normal)
        okButton.center.x = self.view.center.x - 5
        okButton.addTarget(self, action: #selector(dismissAlert), for:.touchUpInside)
        okButton.setLagreeRedColor()
        vc!.view.addSubview(okButton)
        
        
        /**let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.view.addSubview(vc!.view)
        **/
        present(vc!, animated: true, completion: nil)
    }
    
    @objc func dismissAlert()
    {
        if (self.vc != nil) {
            self.vc!.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func goBack(){
        
        self.navigationController?.popViewController(animated: true)
        
           /**let storyBoard = UIStoryboard(name: "Main", bundle:nil)
           let memberDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "WelcomeController")

           if(self.navigationController == nil)
           {
               print("self.navigationController == nil")

           }

           self.navigationController?.pushViewController(memberDetailsViewController, animated: true)

         **/
    }
   

   
    
    
    func alertLocationDisabled()
    {
        let alert = UIAlertController(title: "Location disabled".localized, message: "Please go to Settings, enable location service and try again".localized, preferredStyle: UIAlertController.Style.alert)
        
        let settingsAction = UIAlertAction(title: "Settings".localized, style: .default) { (_) -> Void in
            DispatchQueue.main.async {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    } else {
                        UIApplication.shared.openURL(settingsUrl as URL)
                    }
                }
            }
        }
        alert.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
        alert.addAction(cancelAction)
        
        
        if !(UIApplication.topViewController() is UIAlertController) {
            UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
        }
    }
    
}
