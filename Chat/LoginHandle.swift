//
//  LoginHandle.swift
//  Chat
//
//  Created by Amir Afzali on 2018-05-01.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit
import Alamofire

class LoginHandle {
    var email, pass: String!
    
    init(email: String!, pass: String!) {
        self.email = email
        self.pass = pass
    }
    
    func getPass(completionBlock: @escaping (String) -> Void) -> Void {
        let parameters: Parameters = [
            "email": String(email),
            "pass": String(pass)
        ]
        Alamofire.request("http://hypotest.net/rogers/loginvalid.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! NSDictionary
                completionBlock(meh["valid"] as! String)
                
            }
        }
    }

}
