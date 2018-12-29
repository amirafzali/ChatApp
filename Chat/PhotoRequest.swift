//
//  PhotoRequest.swift
//  Rogers
//
//  Created by Amir Afzali on 2018-05-08.
//  Copyright © 2018 Amir. All rights reserved.
//

import Alamofire
import AlamofireImage

class PhotoRequest {
    

    static func uploadImage(image : UIImage, toID: String!) {
        
        let imageData = UIImageJPEGRepresentation(image, 1)
        let email: String! = UserDefaults.standard.object(forKey: "Email") as! String
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(toID.data(using: String.Encoding.utf8)!, withName: "to")
            multipartFormData.append(email.data(using: String.Encoding.utf8)!, withName: "from")
            multipartFormData.append(imageData!, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
        }, to:"http://hypotest.net/rogers/upload.php")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                    }
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }
    }
    static func getPhoto(id: String!) {
        let email: String! = UserDefaults.standard.object(forKey: "Email") as! String
        let parameters: Parameters = [
            "to_email": String(email),
            "from_id": String(id)
        ]
        Alamofire.request("http://hypotest.net/rogers/getphotos.php", method: .post, parameters: parameters).responseImage { response in
            print(response.description)
            print(id)
            if let data = response.result.value {
                images[id!] = data
            }
        }
    }
    static func open(id: String!) {
        let email: String! = UserDefaults.standard.object(forKey: "Email") as! String
        let parameters: Parameters = [
            "open": "y",
            "to_email": String(email),
            "from_id": String(id)
        ]
        Alamofire.request("http://hypotest.net/rogers/getphotos.php", method: .post, parameters: parameters)
    }
}
