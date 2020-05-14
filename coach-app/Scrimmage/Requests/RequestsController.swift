
//

import UIKit

class RequestsController: AbstractViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sentButton: UIButton!
    
    @IBOutlet weak var recievedButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var allSource:[Request] = []
    var source:[Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        addScrimmageNavBarBack(title: "RECIEVED REQUESTS")
        tableView.separatorStyle = .none

        recievedButton.setTitleColor(UIColor.coachGreen(), for: .normal)
        
        //tableView.scrollToBottom(animated: false)
        
        getRequests()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
        
    }
    
     // MARK: - Table view data source
            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
                CGFloat {
                    return 180.0
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
                let request = source[indexPath.row]
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "RequestsViewCell", for: indexPath) as! RequestsViewCell
                //Set row fields
                var role = "PLAYER"
                
                if(request.team_id != nil){
                    role = "TEAM"
                }else if(request.official_id != nil){
                    role = "OFFICIAL"
                }else if(request.player_id != nil){
                    role = "PLAYER"
                }
                cell.fromNameLabel.text = request.name!.uppercased() + " (" + role + ")"
                cell.fromNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                let stringToDate = request.created_on!.toDate()
                let dateToString = stringToDate.monthAndDay
                cell.dateTimeLabel.text = dateToString
                cell.messageLabel.text = request.message
                cell.fromLabel.textColor = UIColor.coachGreen()
                cell.fromLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
                //i dalje ne znam gde da stavim ovo jer mi je soruce samo ovde != 0
                let counter = String(source.count)
                let sentButtonTitle = "SENT (" + counter + ")"
                sentButton.setTitle(sentButtonTitle, for: .normal)
                let recievedButtonTitle = "RECIEVED (" + counter + ")"
                recievedButton.setTitle(recievedButtonTitle, for: .normal)
                
                return cell
            }
            
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           //Get Notification object

            let storyBoard = UIStoryboard(name: "Scrimmage", bundle:nil)
            let destController = storyBoard.instantiateViewController(withIdentifier: "MessagesController") as! MessagesController

            self.navigationController?.pushViewController(destController, animated: true)
        }
        
    @IBAction func sentButtonClicked(_ sender: Any) {
        source.removeAll()
        for item in allSource {
            if(item.created_by == UserDef().id){
                self.source.append(item)
            }
        }
        tableView.reloadData()
    }
    
    @IBAction func receivedButtonClicked(_ sender: Any) {
        source.removeAll()
        for item in allSource {
            if(item.created_by != UserDef().id){
                self.source.append(item)
            }
        }
        tableView.reloadData()
    }
    
    //REQUESTS
    func getRequests(){
        
        let dm = DataManager()
        recievedButton.startAnimating()
        print("kreno sam da se vrtim 1")
        dm.getRequests(completion: { (json) -> Void in
                    //Go next
                    DispatchQueue.main.async(execute: {
                        let status = json["status"]
                        //Success
                        if(status == "success"){
                            
                            let result = json["result"]
                            
                            for item in result["list"].arrayValue {
                                let request:Request = Request(json: item)
                                self.allSource.append(request)
                                if(request.created_by != UserDef().id){
                                    self.source.append(request)
                                }                            }
                            self.recievedButton.startAnimating()
                            print("kreno sam da se vrtim 2")

                            self.tableView.reloadData()
                            
                            
                        }else{
                            //Api Error
                            // Display alert message
                            self.alert(msg: "Error getting search results".localized)
                        }
                        self.recievedButton.stopAnimating()
                        print("presto sam da se vrtim 1")

                    })
            })
        }
        
        

    }


