//
//  ItemMapsViewController.swift
//  FoundIt
//
//  Created by Krishna on 20/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase


class ItemMapsViewController: UIViewController {

   
    @IBOutlet weak var myMapView: UIView!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let camera = GMSCameraPosition.cameraWithLatitude(42.96336,
                                                          longitude:-85.66809, zoom:15)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera:camera)
        for i in 0 ..< (appDelegate.activeItemCount) {

            let itemLocation = NSUserDefaults.standardUserDefaults().objectForKey("location-" + String(i)) as? NSArray
            if itemLocation != nil {
            let lat =  itemLocation![0] as! String
            let long = itemLocation![1] as! String
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(Double(lat)!, Double(long)!)
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.icon = UIImage(named: "flag_icon")
            marker.map = mapView
            
            }

        }
        self.view = mapView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onCancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
