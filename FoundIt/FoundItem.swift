//
//  FoundItem.swift
//  FoundIt
//
//  Created by Krishna on 16/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import Firebase

class FoundItem {
    // MARK: Properties
    let displayName: String!
    let itemDescription: String!
    let foundLocation: String!
    let dropLocation: String!
    let imageKey: String!
    let currentLat: String!
    let currentLong: String!
//    let postedby: String!
    
    // MARK: Initialization
    init(displayName: String, itemDescription: String, foundLocation: String, dropLocation: String, imageKey: String, currentLat: String, currentLong: String, key: String = "") {
        //self.key = key
        self.displayName = displayName
        self.itemDescription = itemDescription
        self.foundLocation = foundLocation
        self.dropLocation = dropLocation
        self.imageKey = imageKey
        self.currentLat = currentLat
        self.currentLong = currentLong
//        self.postedby = FIRAuth.auth()?.currentUser?.uid
    }
    
    
    init(snapshot: FIRDataSnapshot) {
        displayName = snapshot.value!["displayName"] as! String
        itemDescription = snapshot.value!["itemDescription"] as! String
        foundLocation = snapshot.value!["foundLocation"] as! String
        dropLocation = snapshot.value!["dropLocation"] as! String
        imageKey = snapshot.value!["imageKey"] as! String
        currentLat = snapshot.value!["currentLat"] as! String
        currentLong = snapshot.value!["currentLong"] as! String
    }
    
    
    init(snapshot: Dictionary<String,AnyObject>) {
        displayName = snapshot["displayName"] as! String
        itemDescription = snapshot["itemDescription"] as! String
        foundLocation = snapshot["foundLocation"] as! String
        dropLocation = snapshot["dropLocation"] as! String
        imageKey = snapshot["imageKey"] as! String
        currentLat = snapshot["currentLat"] as! String
        currentLong = snapshot["currentLong"] as! String
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "displayName": displayName,
            "itemDescription": itemDescription,
            "foundLocation": foundLocation,
            "dropLocation": dropLocation,
            "imageKey": imageKey,
            "currentLat": currentLat,
            "currentLong": currentLong,
        ]
    }
    
    
    
}

class ItemCount {
    
    let activeItemCount: Int!
    
    // MARK: Initialization
    init(activeItemCount: Int) {
        //self.key = key
        self.activeItemCount = activeItemCount
    }
    
    
    init(snapshot: FIRDataSnapshot) {
        activeItemCount = snapshot.value!["activeItemCount"] as! Int
    }
    
    
    init(snapshot: Dictionary<String,AnyObject>) {
        activeItemCount = snapshot["activeItemCount"] as! Int
    }
    
    
    func toAnyObject() -> AnyObject {
        return [
            "activeItemCount": activeItemCount,
        ]
    }


}

class MyCurrLocation {
    let currLatitude: String
    let currLongitude: String
    
    init(currLatitude: String, currLongitude: String) {
        //self.key = key
        self.currLatitude = currLatitude
        self.currLongitude = currLongitude
    }
}

