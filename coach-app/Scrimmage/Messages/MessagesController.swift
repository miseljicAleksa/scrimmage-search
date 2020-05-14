
import UIKit

class MessagesController: AbstractViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var sendMessageButton: UIButton!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var typeMessageContainer: UIView!
    @IBOutlet weak var requestLabel: UILabel!

    @IBOutlet weak var declinedRequest: UIButton!
    @IBOutlet weak var acceptedRequest: UIView!
    @IBOutlet weak var containerRequest: UIView!
    @IBOutlet weak var tableView: UITableView!
    
var source:[Message] = []



override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    addScrimmageNavBarBack(title: "REQUESTS DETAILS")


    tableView.scrollToBottom(animated: false)

    getMessages(request_id: "1")
    //design
    acceptedRequest.backgroundColor = UIColor.coachGreen()
    declinedRequest.backgroundColor = UIColor.coachGrey()
    sendMessageButton.backgroundColor = UIColor.coachGreen()
    containerRequest.backgroundColor = .white
    tableView.backgroundColor = UIColor.coachGrey()
    tableView.separatorStyle = .none
    //Added
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 200
    tableView.backgroundColor = UIColor.coachGrey()
    

}

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)



    self.tableView.reloadData()

}
 // MARK: - Table view data source
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
            CGFloat {
                    return UITableView.automaticDimension
                
                
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
            let message = source[indexPath.row]
            let def = UserDefaults.standard
            let user_id = def.string(forKey: "id")
            var cell = MessageCell()
            
            if(message.user_from == user_id){
                 cell = tableView.dequeueReusableCell(withIdentifier: "SentMessageCell", for: indexPath) as! MessageCell
                 cell.messageSent.text = message.message
                let stringToDate = message.created_on!.toDate()
                let dateToString = stringToDate.monthAndDay
                cell.messageDateTime.text = dateToString
                cell.messageDateTime.textColor = .darkGray
                //cell.messageSent.backgroundColor = .white
            }else{
                 cell = tableView.dequeueReusableCell(withIdentifier: "RecievedMessageCell", for: indexPath) as! MessageCell
                 cell.messageSent.text = message.message
                 let stringToDate = message.created_on!.toDate()
                 let dateToString = stringToDate.monthAndDay
                 cell.messageDateTime.text = dateToString
                 cell.messageDateTime.textColor = .darkGray
                 cell.messageSent.backgroundColor = UIColor.coachGreen()
                 cell.messageSent.textColor = .white

                
            }
            
           //design
            requestLabel.text = "REQUEST YOU HAVE RECIEVED FROM " + message.name!.uppercased() + " ROLE TO DO"
            

            return cell
        }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //Get Notification object


    }



//REQUESTS
    func getMessages(request_id: String){

    let dm = DataManager()
//    buttonOutlet.startAnimating()
        dm.getMessages(request_id: request_id, completion: { (json) -> Void in
                //Go next
                DispatchQueue.main.async(execute: {
                    let status = json["status"]
                    //Success
                    if(status == "success"){
                        var messages:[Message] = []
                        let result = json["result"]

                        for item in result["list"].arrayValue {
                            let message:Message = Message(json: item)
                            let def = UserDefaults.standard
                            messages.append(message)
                            
                        }
                        self.source = messages
                        let def = UserDefaults.standard
                        
                        print("!!!!! get messages !!!!!!§")
                        print(def.string(forKey: "id"))
                        print(self.source.count)

//                        self.buttonOutlet.stopAnimating()

                        self.tableView.reloadData()


                    }else{
                        //Api Error
                        // Display alert message
                        self.alert(msg: "Error getting search results".localized)
                    }
//                    self.buttonOutlet.stopAnimating()
                })
        })
    }
    
    func sendMessage(request_id: String, message: String){
            
            let dm = DataManager()
        //    buttonOutlet.startAnimating()
            dm.sendMessage(request_id: request_id, message: message, completion: { (json) -> Void in
                        //Go next
                        let status = json["status"]
                        let result = json["result"]
                        let message = json["message"]
                        print(status, result, message)
                        if(status == "success"){
                            
                            //Go next
                            DispatchQueue.main.async(execute: {
                                print("POSLUKA PORATAAAAAAA")
    //                            self.saveButton.stopAnimating()
                            })
                        }else{
                           
                            DispatchQueue.main.async(execute: {
    //                            self.saveButton.stopAnimating()
                                if(message == "0")
                                {
                                    // Display alert message
                                    self.alert(msg: "Unable to send message, try again".localized)
                                }else
                                {
                                    // Display alert message
                                    self.alert(msg: "Unable to send message, try again".localized)
                                }
                            })
                        }
                })
                }
    
    
    func setRequestStatus(request_id: String, status: String){
            
            let dm = DataManager()
        //    buttonOutlet.startAnimating()
            dm.setRequestStatus(request_id: request_id, status: status, completion: { (json) -> Void in
                        //Go next
                        let status = json["status"]
                        let result = json["result"]
                        let message = json["message"]
                        print(status, result, message)
                        if(status == "success"){

                            //Go next
                            DispatchQueue.main.async(execute: {
    //                            self.saveButton.stopAnimating()
                                self.getMessages(request_id: "1")

                            })
                        }else{
                           
                            DispatchQueue.main.async(execute: {
    //                            self.saveButton.stopAnimating()
                                if(message == "0")
                                {
                                    // Display alert message
                                    self.alert(msg: "Unable to send message, try again".localized)
                                }else
                                {
                                    // Display alert message
                                    self.alert(msg: "Unable to send message, try again".localized)
                                }
                            })
                        }

                })
                }

    
    @IBAction func acceptedClicked(_ sender: Any) {
        setRequestStatus(request_id: "1", status: "1")
        containerRequest.isHidden = !containerRequest.isHidden
        let topConstraint = containerRequest.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -10)
        NSLayoutConstraint.activate([topConstraint])


    }
    
    @IBAction func declineClicked(_ sender: Any) {
        setRequestStatus(request_id: "1", status: "0")
        containerRequest.isHidden = !containerRequest.isHidden
        let topConstraint = containerRequest.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -10)
        NSLayoutConstraint.activate([topConstraint])
    }
    
    @IBAction func sentButtonClicked(_ sender: Any) {
        let message = messageTextView.text
        sendMessage(request_id: "1", message: message!)
        getMessages(request_id: "1")
        self.tableView.reloadData()
        self.tableView.scrollToBottom(animated: true)


    }
    
    
}


