//
//  FriendRequest.swift
//  Rogers
//
//  Created by Amir Afzali on 2018-05-08.
//  Copyright © 2018 Amir. All rights reserved.
//


import Alamofire

class FriendRequest {
    var toEmail: String!
    
    init(toEmail: String!) {
        self.toEmail = toEmail
    }
    
    func addFriend(completionBlock: @escaping (String) -> Void) -> Void {
        print("e")
        let email: String! = UserDefaults.standard.object(forKey: "Email") as! String
        let parameters: Parameters = [
            "from_user": String(email),
            "to_user": String(toEmail),
            "type": "add"
        ]
        print(email)
        Alamofire.request("http://hypotest.net/rogers/friends.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! NSDictionary
                completionBlock(meh["tid"] as! String)
            }
        }
    }
    
    static var timer: DispatchSourceTimer?
    
    static func startTimer() {
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)
        
        timer?.cancel()
        
        timer = DispatchSource.makeTimerSource(queue: queue)
        
        timer?.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(100))
        
        
        timer?.setEventHandler {
            getFriends()
            getIDS()
            setImages()
        }
        
        timer?.resume()
    }
    
    
    
    static func getFriends() {
        let email: String! = UserDefaults.standard.object(forKey: "Email") as? String
        let parameters: Parameters = [
            "friends": "y",
            "email": String(email)
        ]
        Alamofire.request("http://hypotest.net/rogers/retrieve.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! [String]
                friends=meh
            }
        }
    }
    static func getIDS() {
        let email: String! = UserDefaults.standard.object(forKey: "Email") as! String
        let parameters: Parameters = [
            "ids": "y",
            "email": String(email)
        ]
        Alamofire.request("http://hypotest.net/rogers/retrieve.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! [String]
                ids = meh
            }
        }
    }
    
    static func setImages() {
        for id in ids {
            print(images[String(id)])
            if images[String(id)] == nil {
                PhotoRequest.getPhoto(id: id)
            }
        }
    }
}
