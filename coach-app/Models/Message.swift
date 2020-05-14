import Foundation

struct Message {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    
    var user_from: String? {
        return json["user_from"].string
    }
    
    var created_on: String? {
        return json["created_on"].string
    }
    
    var message: String? {
        return json["message"].string
    }
    
    var viewed: String? {
        return json["viewed"].string
    }
    
    
    var request_id: String? {
        return json["request_id"].string
    }
    
    var name: String? {
        return json["name"].string
    }
    
    
}
