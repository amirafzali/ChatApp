//
//  PasswordViewController.swift
//  Rogers
//
//  Created by Amir on 2018-04-30.
//  Copyright © 2018 Ned. All rights reserved.
//

import UIKit
import Hero

class PasswordView: UIViewController {
    
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var err1: UILabel!
    @IBOutlet weak var err2: UILabel!
    @IBOutlet weak var err3: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    
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
    
    @IBAction func registerPressed(_ sender: Any) {
        if validate() {
            RegisterRequest(firstName: nil, lastName: nil, number: nil, email: nil, pass:passField.text!).setPassword()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let next = storyBoard.instantiateViewController(withIdentifier: "login")
            next.hero.modalAnimationType = .cover(direction: HeroDefaultAnimationType.Direction.up)
            self.hero.replaceViewController(with: next)
        }
    }
    func validate() -> Bool {
        if passField.text?.count != confirmField.text?.count {
            err1.isHidden = false
            err2.isHidden = false
            err3.isHidden = true
            return false
        } else if (passField.text?.count)! < 4 {
            err3.frame.origin = CGPoint(x: 53, y: 286)
            err1.isHidden = true
            err2.isHidden = false
            err3.isHidden = false
            return false
        }
        err1.isHidden = true
        err2.isHidden = true
        err3.isHidden = true
        return true
    }
    
    
}
