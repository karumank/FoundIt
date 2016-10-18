//
//  Extensions.swift
//  FoundIt
//
//  Created by Krishna on 09/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit

extension UIColor {
  convenience init(colorArray array: NSArray) {
    let r = array[0] as! CGFloat
    let g = array[1] as! CGFloat
    let b = array[2] as! CGFloat
    self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha:1.0)
  }
}

extension UIImage {
    var uncompressedPNGData: NSData      { return UIImagePNGRepresentation(self)!        }
    var highestQualityJPEGNSData: NSData { return UIImageJPEGRepresentation(self, 1.0)!  }
    var highQualityJPEGNSData: NSData    { return UIImageJPEGRepresentation(self, 0.75)! }
    var mediumQualityJPEGNSData: NSData  { return UIImageJPEGRepresentation(self, 0.5)!  }
    var lowQualityJPEGNSData: NSData     { return UIImageJPEGRepresentation(self, 0.25)! }
    var lowestQualityJPEGNSData:NSData   { return UIImageJPEGRepresentation(self, 0.0)!  }
}
