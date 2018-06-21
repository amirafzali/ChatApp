//
//  PhotoRequest.swift
//  Rogers
//
//  Created by Amir on 2018-05-08.
//  Copyright © 2018 Ned. All rights reserved.
//

import Alamofire

class PhotoRequest {
    
    func sendPhoto(user: String, completionBlock: @escaping (String) -> Void) -> Void {
        let parameters: Parameters = [
            "pass": "passwd"
        ]
        Alamofire.request("http://hypotest.net/rogers/code.php", method: .post, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                let meh = json as! NSDictionary
                completionBlock(meh["verification"] as! String)
            }
        }
    }
}
