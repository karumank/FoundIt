//
//  MenuItemCell.swift
//  FoundIt
//
//  Created by Krishna on 09/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
  
  @IBOutlet weak var menuItemImageView: UIImageView!
  
  func configureForMenuItem(menuItem: NSDictionary) {
    menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
    backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
  }
  
}
