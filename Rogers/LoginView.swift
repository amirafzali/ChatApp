//
//  Login.swift
//  Rogers
//
//  Created by Amir on 2018-04-18.
//  Copyright © 2018 Ned. All rights reserved.
//
import Hero
import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    let enabledColour: CGColor! = UIColor.init(red: 1.00, green: 0.20, blue: 0.39, alpha: 1.0).cgColor
    let disabledColour: CGColor! = UIColor.init(red: 1.00, green: 0.62, blue: 0.71, alpha: 1.0).cgColor
    
    let gradient6: UIColor! = UIColor(red:0.88, green:0.93, blue:0.76, alpha:1.0)
    let gradient7: UIColor! = UIColor(red:1.00, green:0.72, blue:0.55, alpha:1.0)
    
    @IBOutlet weak var loginError: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setup() {
        self.hero.isEnabled = true;
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        loginButton.layer.cornerRadius = 7
        loginButton.layer.borderWidth = 0.5
        registerButton.layer.cornerRadius = 7
        registerButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor =
            UIColor.init(red: 1.00, green: 0.20, blue: 0.39, alpha: 1.0).cgColor
        registerButton.layer.borderColor = UIColor.init(red: 0.46, green: 0.84, blue: 1.00, alpha: 1.0).cgColor
        
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        gradientView.colors = [gradient6, gradient7]
        gradientView.locations = [0.3, 1.0]
        gradientView.direction = .vertical
        gradientView.topBorderColor = .red
        gradientView.bottomBorderColor = .blue
        view.addSubview(gradientView)
        view.sendSubview(toBack: gradientView)
        
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        LoginHandle(email: usernameField.text, pass: passwordField.text).getPass() { (output) in
            expected = (output == "true")
            if(expected) {
                self.loginError.isHidden = true
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "camera")
                nextViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
                self.present(nextViewController, animated:true, completion:nil)
            } else {
                self.loginError.isHidden = false
            }
        }
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "register1")
        
        nextViewController.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
        
        self.present(nextViewController, animated:true, completion:nil)
        
    }
    @IBAction func usernameEdit(_ sender: Any) {
        if usernameField.text?.replacingOccurrences(of: " ", with: "").count != 0 && passwordField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            loginButton.isEnabled = true
            loginButton.layer.backgroundColor = enabledColour
        } else {
            loginButton.isEnabled = false;
            loginButton.layer.backgroundColor = disabledColour
        }
    }
    @IBAction func passwordEdit(_ sender: Any) {
        if usernameField.text?.replacingOccurrences(of: " ", with: "").count != 0 && passwordField.text?.replacingOccurrences(of: " ", with: "").count != 0 {
            loginButton.isEnabled = true
            loginButton.layer.backgroundColor = enabledColour
        } else {
            loginButton.isEnabled = false;
            loginButton.layer.backgroundColor = disabledColour
        }
    }
    

}
