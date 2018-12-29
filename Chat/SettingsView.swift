//
//  SettingsView.swift
//  Chat
//
//  Created by Amir on 2018-06-21.
//  Copyright © 2018 Ned. All rights reserved.
//

import UIKit
import Hero

class SettingsView: UIViewController {

    @IBOutlet weak var friendsButton: UIButton!
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedFriends(_ sender: Any) {
        let next = self.storyBoard.instantiateViewController(withIdentifier: "friends")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
    }
    
    
    @IBAction func pressedLogout(_ sender: Any) {
        let next = self.storyBoard.instantiateViewController(withIdentifier: "login")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
    }
    
}
