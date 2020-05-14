import UIKit

class GamesHistoryController : AbstractViewController,UITableViewDelegate,UITableViewDataSource {
    var activityIndicatorView: UIActivityIndicatorView!
    var customTransitioningDelegate = TransitioningDelegate()
    var rows: [String]! = nil
    //Setup if presenting as popup
   func configure() {
       customTransitioningDelegate.height = 600
       modalPresentationStyle = .custom
       modalTransitionStyle = .crossDissolve // use whatever transition you want
       transitioningDelegate = customTransitioningDelegate
   }
    var team_id:String?
    var official_id:String?
    var source:[Game] = []

    @IBOutlet weak var closeButton: UIButton!
    @IBAction func closeButtonClicker(_ sender: Any) {
        self.dismiss(animated:true, completion:nil)
    }
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loader
        let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        
        //usual setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        closeButton.backgroundColor = UIColor.coachGreen()
        
        //Using same controller for game and refereed history
        if(team_id != nil)
        {
            getGamesHistory(team_id: team_id!)
        }
        if(official_id != nil)
        {
            getRefereedHistory(official_id: official_id!)
        }
    }
    
    //will apear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (rows == nil) {
            activityIndicatorView.startAnimating()
        }else{
            activityIndicatorView.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicatorView.stopAnimating()

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
//            if (source.count == 0) {
//                activityIndicatorView.startAnimating()
//            }else{
//                activityIndicatorView.stopAnimating()
//            }
            return source.count

        }


        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            //Get Notification object
            let game = source[indexPath.row]

            let cell = tableView.dequeueReusableCell(withIdentifier: "GamesHistoryViewCell", for: indexPath) as! GamesHistoryViewCell
            //Set row fields
            cell.gamesDateOutlet.text = game.date_and_time
            cell.vsTeamOutlet.text = game.city
            cell.gameRateOutlet.text = "4.3"
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
    
    func getGamesHistory(team_id: String){
        let dm = DataManager()
           
        //loader.startAnimating()
        DispatchQueue.global(qos: .background).async {
            dm.getGamesHistory(team_id: team_id, completion: { (json) -> Void in

                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    if(status == "success"){
                           
                       for (_, item) in json["result"]["list"] {
                           let game = Game(json: item)
                           self.source.append(game)
                       }
                       
                       }else{
                               //self.loader.stopAnimating()
                       }

                        //self.loader.stopAnimating()
                        self.tableView.reloadData()
                })
           })
        }
    }

    func getRefereedHistory(official_id: String){
        let dm = DataManager()
           
        //loader.startAnimating()
        DispatchQueue.global(qos: .background).async {
            dm.getRefereedHistory(official_id: official_id, completion: { (json) -> Void in

                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    if(status == "success"){
                           
                       for (_, item) in json["result"]["list"] {
                           let game = Game(json: item)
                           self.source.append(game)
                       }
                       
                       }else{
                               //self.loader.stopAnimating()
                       }

                        //self.loader.stopAnimating()
                        self.tableView.reloadData()
                })
           })
        }
    }




}
