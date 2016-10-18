//
//  PostsTableViewCell.swift
//  FoundIt
//
//  Created by Krishna on 18/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import Firebase

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameField: UILabel!
    @IBOutlet weak var foundAtField: UILabel!
    @IBOutlet weak var droppedAtField: UILabel!
    @IBOutlet weak var postedByField: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
