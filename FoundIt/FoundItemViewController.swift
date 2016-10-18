//
//  FoundItemViewController.swift
//  FoundIt
//
//  Created by Krishna on 16/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase


class FoundItemViewController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var uploadProgressView: UIProgressView!
    @IBOutlet weak var displayNameTxt: UITextField!
    
    @IBOutlet weak var itemDescTxt: UITextView!
    @IBOutlet weak var foundLocationTxt: UITextField!
    @IBOutlet weak var dropLocationTxt: UITextField!
    var ref : FIRDatabaseReference?
    let locationManager = CLLocationManager()
    var currLat = "42.96233" //Default to Allendale GVSU
    var currLong = "-85.89659" //Default to Allendale GVSU
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = FIRDatabase.database().reference()
        itemDescTxt.delegate = self
        itemDescTxt.text = "Short Description about the found item goes here..."
        itemDescTxt.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var location = locations.last
        currLat = String(location!.coordinate.latitude)
        currLong = String(location!.coordinate.longitude)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickUpload(sender: AnyObject) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            var imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clearColor()
        self.dismissViewControllerAnimated(true, completion: nil)
        //uploadImageData()
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        myImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil);
        //uploadImageData()
    }
    
    @IBAction func onSaveForm(sender: AnyObject) {
        
        //Save Image to Firebase Storage
        var uuid = NSUUID().UUIDString
        let myFirebaseStorage = FIRStorage.storage()
        let storageRef = myFirebaseStorage.referenceForURL("gs://project-4370450791267946106.appspot.com")
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 0.0)
        //UIImageJPEGRepresentation(self, 0.0)
        if (imageData == nil) { return }
        
        // Create a reference to the file you want to upload
        let riversRef = storageRef.child("FoundItems/" + uuid + ".jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = riversRef.putData(imageData!, metadata: nil) { metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL
            }
        }
        
        //Save other details to Firebase Realtime Database
        let entry = FoundItem(displayName: displayNameTxt.text!, itemDescription: itemDescTxt.text!, foundLocation: foundLocationTxt.text!, dropLocation: dropLocationTxt.text!, imageKey: uuid, currentLat: currLat, currentLong: currLong)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let availableItemCount = appDelegate.activeItemCount
        let fileName = "item-" + String(availableItemCount)
        self.ref?.child("found-items").child(fileName).setValue(entry.toAnyObject())
        
        let itemCount = ItemCount(activeItemCount: (availableItemCount + 1))
        self.ref?.child("item-count").setValue(itemCount.toAnyObject())
        appDelegate.activeItemCount = appDelegate.activeItemCount + 1
        
        let alertController = UIAlertController(title: "You are awesome!!", message:
            "Thanks for helping us find the owner of the item you found..", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
       self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.textColor == UIColor.lightGrayColor() {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Short Description about the found item goes here..."
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
