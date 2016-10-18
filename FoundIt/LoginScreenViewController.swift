//
//  LoginScreenViewController.swift
//  FoundIt
//
//  Created by Krishna on 10/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userEmail.delegate = self;
        self.userPassword.delegate = self;
        //self.setupButtons()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func onClickLogin(sender: AnyObject) {
        FIRAuth.auth()?.signInWithEmail(userEmail.text!, password: userPassword.text!, completion: { (user, error) in
            if error != nil {
                let alertController = UIAlertController(title: "Alert", message:
                    "OOPS! Incorrect Username/Password", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            else
            {
                let myString = FIRAuth.auth()?.currentUser?.email
                var array : [String] = myString!.componentsSeparatedByCharactersInSet(NSCharacterSet (charactersInString: "@ "))
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.loggedInUserName = array[0]
                
                let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ContainerVC")
                self.presentViewController(vc!, animated: true, completion: nil)
            }
        })
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
