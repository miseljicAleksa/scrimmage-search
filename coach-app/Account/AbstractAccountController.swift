//
//  AbstractAccountController.swift
//  coachingApp
//
//  Created by alk msljc on 10/24/19.
//  Copyright © 2019 alk msljc. All rights reserved.
//

import UIKit



class AbstractAccountController: AbstractViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func DismissKeyboard(){
        //Causes the view to resign from the status of first responder.
        //view.endEditing(true)
        if let fRview = self.findActiveResponderFrame(view: self.view)
        {
            fRview.resignFirstResponder()
        }
    }
    
    func findActiveResponderFrame(view:UIView)->UIView?{
        if view.isFirstResponder {
            return view
        } else {
            for sub in view.subviews {
                if let subView = sub as? UIView,
                    let found = findActiveResponderFrame(view: subView){
                    return found
                }
            }
        }
        return nil
    }
    
    //Hide status bar
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return false
    }
    
    
    /// Description: Add custom navigation bar
    /// - Parameter title: title of left label
    /// - Parameter back: modifier of controller to be sequed to
    func addCustomBar(title: String, back: String = "")
    {
        let screenHeight = UIScreen.main.bounds.size.height
        
        var topOffset = CGFloat(60)
        if screenHeight < 569 {
            //iPhone SE
            topOffset = 20
        }
        
        //View
        let myView = UIView(frame: CGRect(x: 0, y: topOffset, width:view.frame.maxX, height: 30))
        //myView.backgroundColor = UIColor.white
        
        
        //Title
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        label.text = title
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        //label.font = UIFont(name:"avenirNext-Meduim",size:20)
        label.center = myView.center
        label.center = CGPoint(x: label.center.x, y: label.center.y - topOffset )
        myView.addSubview(label)
        label.textAlignment = .center
        
        
        
        //Back button
        let image = UIImage(named: "back") as UIImage?
        let button = MyButton(type: UIButton.ButtonType.custom) as MyButton
        button.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        button.setImage(image, for: .normal)
        button.backController = back
        button.addTarget(self, action: #selector(backAccountTouched(sender:)), for:.touchUpInside)
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
        
        
        
        
        self.view.addSubview(myView)
    }
    
    
    @objc func backAccountTouched (sender: MyButton)
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
    
    
    //Lock orientation
    override open var shouldAutorotate: Bool {
        return false
    }
    
    
    // Specify the orientation.
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func SetBackBarButtonCustom()
    {
        //Back buttion
        self.navigationItem.setHidesBackButton(false, animated: false)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.plain, target:nil, action:nil)
    }

    @objc func onClickBack()
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
class MyButton: UIButton {
    var backController: String?
}
