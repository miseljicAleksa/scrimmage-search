//
//  Notification.swift
//  Scrimmage Search
//
//  Created by alk msljc on 2/13/20.
//  Copyright © 2020 alk msljc. All rights reserved.
//

import Foundation

struct Notification {
    
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    var user_to: String? {
        return json["user_to"].string
    }
    var user_from: String? {
        return json["user_from"].string
    }
    var viewed: String? {
        return json["viewed"].string
    }
    var message: String? {
        return json["message"].string
    }
    var created_on: String? {
        return json["created_on"].string
    }
    
}
