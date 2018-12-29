//
//  FriendViewCell.swift
//  Chat
//
//  Created by Amir Afzali on 2018-06-21.
//  Copyright © 2018 Amir. All rights reserved.
//

import UIKit

class FriendViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var msgStatus: UIImageView!
    @IBOutlet weak var name: UILabel!
    var id: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
