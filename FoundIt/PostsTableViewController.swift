//
//  PostsTableViewController.swift
//  FoundIt
//
//  Created by Krishna on 17/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseStorage

class PostsTableViewController: UITableViewController {
    
    var ref : FIRDatabaseReference?
    var hamburgerView: HamburgerView?
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationItem.title = "Hey " + appDelegate.loggedInUserName
        //For TOp Logo
        //        let logo = UIImage(named: "TopLogo")
        //        let imageView = UIImageView(image:logo)
        //        self.navigationItem.titleView = imageView

//        navigationController!.navigationBar.clipsToBounds = true
        //tableView.backgroundView = UIImageView(image: UIImage(named: "background"))

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hamburgerViewTapped")
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
    }
    
    func hamburgerViewTapped() {
        let navigationController = parentViewController as! UINavigationController
        let containerViewController = navigationController.parentViewController as! ContainerViewController
        containerViewController.hideOrShowMenu(!containerViewController.showingMenu, animated: true)
    }
    

    @IBAction func onRefreshingScreen(sender: AnyObject) {
        sender.endRefreshing()
        //self.loadVideos()
        self.tableView.reloadData()
    }
 
    @IBAction func onFoundSomething(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("foundItemView")
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let availableItemCount = appDelegate.activeItemCount
        return availableItemCount
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("postCell", forIndexPath: indexPath) as! PostsTableViewCell
        var imageKey = ""
        
      
        
       

        //Get details from Firebase Realtime Database...
        ref!.child("found-items").child("item-" + String(indexPath.row)).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            cell.itemNameField.text = snapshot.value!["displayName"] as! String
            cell.foundAtField.text = snapshot.value!["foundLocation"] as! String
            cell.droppedAtField.text = snapshot.value!["dropLocation"] as! String
            cell.postedByField.text = self.appDelegate.loggedInUserName
            imageKey = snapshot.value!["imageKey"] as! String
            
            let currLat = snapshot.value!["currentLat"] as! String
            let currLong = snapshot.value!["currentLong"] as! String

            let currLocationArray = [currLat, currLong]
            let objectKey = "location-" + String(indexPath.row)

            NSUserDefaults.standardUserDefaults().setObject(currLocationArray, forKey: objectKey)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            //cell.itemNameField.text = snapshot.value!["displayName"] as! String
            //            count = snapshot.value!["activeItemCount"] as! Int
            //            self.activeItemCount = count
            //            print(count)
            
            //Get Image From Firebase Storage...
            let userID = FIRAuth.auth()?.currentUser?.uid
            let myFirebaseStorage = FIRStorage.storage()
            let storageRef = myFirebaseStorage.referenceForURL("gs://project-4370450791267946106.appspot.com")
            let imageURL = "FoundItems/" + imageKey + ".jpg"
            let imageRef = storageRef.child(imageURL)
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Data for "images/island.jpg" is returned
                    // ... let islandImage: UIImage! = UIImage(data: data!)
                    cell.itemImageView.image = UIImage(data: data!)
                }
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

        return cell
    }
  

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
