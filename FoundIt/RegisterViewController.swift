//
//  RegisterViewController.swift
//  FoundIt
//
//  Created by Krishna on 09/06/16.
//  Copyright © 2016 Krishna. All rights reserved.
//
import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickCreateAccount(sender: AnyObject) {
        FIRAuth.auth()?.createUserWithEmail(userEmail.text!, password: userPassword.text!, completion: { (user, error) in
            if error != nil {
                print("something went wrong")
            }
            else
            {
                print("Awesome! User Created")
            }
        })
        
    }
    @IBAction func gotoLogin(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
