//
//  RegisterRequest.swift
//  Rogers
//
//  Created by Amir Afzali on 2018-04-23.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit
import Alamofire

class RegisterRequest {
    var firstName, lastName, number, email, pass: String!
    
    init(firstName: String!, lastName: String!, number: String!, email: String!, pass: String!) {
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.email = email
        self.pass = pass        
    }
    
    init(number: String!) {
        self.number = number;
    }
    
    init(email: String!) {
        self.email = email;
    }
    
    func processRegister() {
        let parameters: Parameters = [
            "email": String(email),
            "first_name": String(firstName),
            "last_name": String(lastName),
            "number": String(number)
        ]
        Alamofire.request("http://hypotest.net/rogers/register.php", method: .post, parameters: parameters)
    }
    
    func verifyEmail(completionBlock: @escaping (String) -> Void) -> Void {
        let parameters: Parameters = [
            "email": String(email),
            "verif": "y"
        ]
        Alamofire.request("http://hypotest.net/rogers/register.php", method: .post, parameters: parameters).responseJSON { response in
            print(response.description)
            if let json = response.result.value {
                let meh = json as! NSDictionary
                completionBlock(meh["valid"] as! String)
            }
        }
    }
    
    
    func getCode(completionBlock: @escaping (String) -> Void) -> Void {
        let parameters: Parameters = [
            "pass": "passwd",
            "num": String(number)
            ]
        Alamofire.request("http://hypotest.net/rogers/code.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! NSDictionary
                completionBlock(meh["verification"] as! String)
            }
        }
    }
    func setPassword() {
        print(pass)
        print(numberText)
        let parameters: Parameters = [
            "pass": String(pass),
            "num": String(numberText)
            ]
        Alamofire.request("http://hypotest.net/rogers/register.php", method: .post, parameters: parameters)
    }

}
