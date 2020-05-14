import Foundation
import UIKit

struct User {
    var json: JSON
    
    
    init(json: JSON) {
        self.json = json
    }
    var id: String? {
        return json["id"].string
    }
    var first_name: String? {
        return json["first_name"].string
    }
    var last_name: String? {
        return json["last_name"].string
    }
    var email: String? {
        return json["email"].string
    }
    var image: String? {
        return json["image_file_name"].string
    }
    var access_token: String? {
        return json["access_token"].string
    }
    var notf: String? {
        return json["notf"].string
    }
    
    static func logout()
    {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "id")
        defaults.removeObject(forKey: "first_name")
        defaults.removeObject(forKey: "last_name")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "image")
        defaults.removeObject(forKey: "access_token")
    }
    
    func login()
    {
        let defaults = UserDefaults.standard
        if self.id != nil{
            defaults.set(String(describing: self.id!), forKey: "id")
        }
        if self.email != nil{
            defaults.set(String(describing: self.email!), forKey: "email")
        }
        if self.first_name != nil{
            defaults.set(String(describing: self.first_name!), forKey: "first_name")
        }
        if self.last_name != nil{
            defaults.set(String(describing: self.last_name!), forKey: "last_name")
        }
        if self.image != nil{
            defaults.set(String(describing: self.image!), forKey: "image")
        }
        if self.access_token != nil{
            defaults.set(String(describing: self.access_token!), forKey: "access_token")
        }
    }
    
    static func getLoggedUser() -> UserDef
    {
        return UserDef()
//        let defaults = UserDefaults.standard
//        var user = User(json: JSON())
//        if (defaults.string(forKey: "access_token") != nil){
//            let enc = JSONEncoder()
//            let userDef = UserDef()
//            let jsonData = try? enc.encode(userDef)
//
//            let json = JSON(jsonData)
//            user = User(json: json)
//        }
//        return user
    }
}

struct UserDef:Codable {
    let id:String
    let first_name:String
    let last_name:String
    let email:String
    let access_token:String
    let image:String
    let notf:String
    init(){
        let defaults = UserDefaults.standard
        self.id = defaults.string(forKey: "id")!
        self.first_name = defaults.string(forKey: "first_name") ?? ""
         self.last_name = defaults.string(forKey: "last_name") ?? ""
         self.email = defaults.string(forKey: "email") ?? ""
         self.access_token = defaults.string(forKey: "access_token") ?? ""
         self.image = defaults.string(forKey: "image") ?? ""
         self.notf = defaults.string(forKey: "notf") ?? ""
    }
}
