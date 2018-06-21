//
//  NumberParse.swift
//  Rogers
//
//  Created by Amir on 2018-04-22.
//  Copyright © 2018 Ned. All rights reserved.
//
import PhoneNumberKit

class DataParse {
    
    public func phoneParse(number: String) -> Bool {
        do {
            let phoneNumberKit = PhoneNumberKit()
            _ = try phoneNumberKit.parse(number, withRegion: "CA", ignoreType: true)
            return true;
        } catch {
            return false;
        }
    }
    public func getPhone(number: String) -> String {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let num = try phoneNumberKit.parse(number, withRegion: "CA", ignoreType: true)
            return String(num.countryCode) + String(num.nationalNumber)
        } catch {
            return ""
        }
        
    }
    public func emailParse(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    
    
    
    public func codeParse(code: String, trying: String) -> Bool {
        return code == trying
    }
}
