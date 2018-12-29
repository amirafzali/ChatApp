//
//  FriendsView.swift
//  Rogers
//
//  Created by Amir Afzali on 2018-05-03.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit
import Alamofire
import Hero

class FriendsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var friendsList: UITableView!
    var elements = friends
    var idList = ids
    @IBOutlet weak var addField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBOutlet weak var err1: UILabel!
    @IBOutlet weak var err2: UILabel!
    
    @IBOutlet weak var previewImageView: UIImageView!
    
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("l")
        return elements.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsList.dequeueReusableCell(withIdentifier: "customCell") as! FriendViewCell
        cell.id = idList[indexPath.row]
        cell.name.text = elements[indexPath.row]
        cell.msgStatus.image = UIImage(named: "cancel.png")
        if images[ids[indexPath.row]] != nil {
            cell.msgStatus.image = UIImage(imageLiteralResourceName: "mail.png")
        } else {
            cell.msgStatus.image = UIImage(imageLiteralResourceName: "cancel.png")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(sending) {
            PhotoRequest.uploadImage(image: curImage, toID: ids[indexPath.row])
            sending = false
            let next = self.storyBoard.instantiateViewController(withIdentifier: "camera")
            next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
            self.hero.replaceViewController(with: next)
        } else {
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height
            print(ids[indexPath.row])
            let image = images[ids[indexPath.row]]
            previewImageView.image = image
            previewImageView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
            previewImageView.isHidden = false
            images[ids[indexPath.row]] = nil
            PhotoRequest.open(id: ids[indexPath.row])
            update()
        }
        
    }
    
    @IBAction func pressedAdd(_ sender: Any) {
        FriendRequest(toEmail: addField.text!).addFriend() { (output) in
            print(output)
            if(output=="1" || output == "2") {
                self.err1.isHidden = false
                self.err2.isHidden = false
            }
            else if(output == "3") {
                self.err1.isHidden = true
                self.err2.isHidden = true
                let alert = UIAlertController(title: "Alert", message: "Friend Added!", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Yay!", style: UIAlertActionStyle.destructive, handler: { action in
                    self.update()
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        self.view.endEditing(true)
        
    }
    func update() {
        DispatchQueue.main.async {
            self.elements = friends
            self.idList = ids
            FriendRequest.getFriends()
            FriendRequest.getIDS()
            self.friendsList.reloadData()
            self.refresh()
        }
    }
    @IBAction func pressedBack(_ sender: Any) {
        let next = self.storyBoard.instantiateViewController(withIdentifier: "camera")
        next.hero.modalAnimationType = .push(direction: HeroDefaultAnimationType.Direction.left)
        self.hero.replaceViewController(with: next)
        sending = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.friendsList.reloadData()
        friendsList.delegate = self
        friendsList.dataSource = self
        previewImageView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gestureRecognizer:)));
        previewImageView.addGestureRecognizer(tapRecognizer)
        
    }
    func refresh() {
        elements = friends
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func imageTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        let tappedImageView = gestureRecognizer.view as! UIImageView!
        tappedImageView?.isHidden = true
        update()
    }

}
