
    import UIKit
    class ConnectToTeamController: UIViewController {
        var customTransitioningDelegate = TransitioningDelegate()
        
        var delegate : PopUpDelegate?
        
        var message: String = "Request to this team has been sent!"
        var subtitle: String = "YOU WILL BE NOTIFIED WHEN THIS TEAM RESPOND"
        
        @IBOutlet weak var messageLabel: UILabel!
        @IBOutlet weak var subtitleLabel: UILabel!
        @IBOutlet weak var closeButtonOutlet: UIButton!
        
        @IBAction func closeButtonClicked(_ sender: Any) {
            self.dismiss(animated: true)
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            closeButtonOutlet.backgroundColor=UIColor.coachGreen()
            messageLabel.text = message
            subtitleLabel.text = subtitle
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

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }
