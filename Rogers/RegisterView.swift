//
//  Register.swift
//  Rogers
//
//  Created by Amir on 2018-04-20.
//  Copyright © 2018 Ned. All rights reserved.
//

import UIKit
import Hero

class RegisterView: UIViewController {

    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var next1: UIButton!
    @IBOutlet weak var next2: UIButton!
    @IBOutlet weak var next3: UIButton!
    @IBOutlet weak var signIn1: UIButton!
    @IBOutlet weak var signIn2: UIButton!
    @IBOutlet weak var signIn3: UIButton!
    
    @IBOutlet weak var errorNumber: UILabel!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorEmail2: UILabel!
    @IBOutlet weak var errorGen: UILabel!
    
    @IBOutlet weak var errorCode: UILabel!
    @IBOutlet weak var errorCode2: UILabel!

    let enabledColour: CGColor! = UIColor.init(red: 0.00, green: 0.59, blue: 1.00, alpha: 1.0).cgColor
    let disabledColour: CGColor! = UIColor.init(red: 0.65, green: 0.84, blue: 1.00, alpha: 1.0).cgColor
    let defaultBorder: CGColor! = UIColor.init(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0).cgColor
    
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    var registering: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        self.hero.isEnabled = true;
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    @IBAction func firstNext(_ sender: UIButton) {
        let next = storyBoard.instantiateViewController(withIdentifier: "register2")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
    }
    @IBAction func secondNext(_ sender: Any) {
        emailText = emailField.text?.replacingOccurrences(of: " ", with: "")
        numberText =  numberField.text
        if(validate(address: emailText, number: numberText) && !registering) {
            registering = true
            numberText = DataParse().getPhone(number: numberText)
            RegisterRequest(email: emailText).verifyEmail() { (output) in
                let expect: Bool! = (output == "true")
                if(!expect) {
                    RegisterRequest(firstName: firstNameText, lastName: lastNameText, number: numberText, email: emailText, pass: nil).processRegister()
                    let next = self.storyBoard.instantiateViewController(withIdentifier: "register3")
                    next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
                    self.hero.replaceViewController(with: next)
                } else {
                    self.errorEmail2.isHidden = false;
                    self.registering = false
                }
            }
        }
    }
    @IBAction func thirdNext(_ sender: Any) {
        if validate(code: codeField.text) {
            let next = storyBoard.instantiateViewController(withIdentifier: "registerPass")
            next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
            self.hero.replaceViewController(with: next)
        }
    }
    
    @IBAction func firstSign(_ sender: UIButton) {
        returnLogin()
    }
    
    @IBAction func secondSign(_ sender: Any) {
        returnLogin()
    }
    
    @IBAction func thirdSign(_ sender: Any) {
        returnLogin()
    }
    
    @IBAction func firstNameEdit(_ sender: Any) {
        firstNameText = firstNameField.text?.replacingOccurrences(of: " ", with: "")
        if firstNameField.text?.replacingOccurrences(of: " ", with: "").count != 0 && lastNameField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            next1.isEnabled = true
            next1.layer.backgroundColor = enabledColour
        } else {
            next1.isEnabled = false
            next1.layer.backgroundColor = disabledColour
            
        }
    }
    @IBAction func lastNameEdit(_ sender: Any) {
        lastNameText = lastNameField.text?.replacingOccurrences(of: " ", with: "")
        if firstNameField.text?.replacingOccurrences(of: " ", with: "").count != 0 && lastNameField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            next1.isEnabled = true
            next1.layer.backgroundColor = enabledColour
        } else {
            next1.isEnabled = false
            next1.layer.backgroundColor = disabledColour
        }
    }
    @IBAction func emailChanged(_ sender: Any) {
        if emailField.text?.replacingOccurrences(of: " ", with: "").count != 0 && numberField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            next2.isEnabled = true
            next2.layer.backgroundColor = enabledColour
        } else {
            next2.isEnabled = false
            next2.layer.backgroundColor = disabledColour

        }
    }
    @IBAction func numberChanged(_ sender: Any) {
        numberText = numberField.text
        if emailField.text?.replacingOccurrences(of: " ", with: "").count != 0 && numberField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            next2.isEnabled = true
            next2.layer.backgroundColor = enabledColour
        } else {
            next2.isEnabled = false
            next2.layer.backgroundColor = disabledColour
        }
    }
    
    @IBAction func codeChanged(_ sender: Any) {
        if (codeField.text?.count)! > 6 {
            codeField.deleteBackward()
        }
        if (codeField.text?.count)! == 6 {
            RegisterRequest(number: numberText).getCode() { (output) in
                check = output
                print(check)
            }
            next3.isEnabled = true
            next3.layer.backgroundColor = enabledColour
        } else {
            next3.isEnabled = false
            next3.layer.backgroundColor = disabledColour
        }
    }
    
    func validate(address: String!, number: String!) -> Bool {
        emailField.layer.masksToBounds = true
        emailField.layer.borderWidth = 1.0
        numberField.layer.masksToBounds = true
        numberField.layer.borderWidth = 1.0
        self.errorEmail2.isHidden = true;
        let parse = DataParse()
        if(!parse.emailParse(email: address)) {
            emailField.layer.borderColor = UIColor.red.cgColor
            numberField.layer.borderColor = defaultBorder
            errorNumber.isHidden = true
            errorEmail.bounds = CGRect.init(x: 53, y: 286, width: 230, height: 15)
            errorEmail.isHidden = false
            errorGen.isHidden = false
            return false
        } else if(!parse.phoneParse(number: number)) {
            numberField.layer.borderColor = UIColor.red.cgColor
            emailField.layer.borderColor = defaultBorder
            errorEmail.isHidden = true
            errorNumber.frame.origin = CGPoint(x: 53, y: 286)
            errorNumber.isHidden = false
            errorGen.isHidden = false
            return false
        } else {
            errorEmail.isHidden = true
            errorNumber.isHidden = true
            errorGen.isHidden = true
            numberField.layer.borderColor = defaultBorder
            emailField.layer.borderColor = defaultBorder
            return true
        }
    }
    
    func returnLogin() {
        let next = storyBoard.instantiateViewController(withIdentifier: "login")
        next.hero.modalAnimationType = .cover(direction: HeroDefaultAnimationType.Direction.up)
        self.hero.replaceViewController(with: next)
    }
    
    func validate(code: String!) -> Bool {
        codeField.layer.masksToBounds = true
        codeField.layer.borderWidth = 1.0
        if DataParse().codeParse(code: check, trying: code) {
            errorCode.isHidden = true
            errorCode2.isHidden = true
            return true
        } else {
            errorCode.isHidden = false
            errorCode2.isHidden = false
            codeField.layer.borderColor = UIColor.red.cgColor
            return false
        }
    }

}

