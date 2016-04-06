//
//  LoginViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/28.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class LoginViewController: UIViewController {
    var Userid = 0
    
    
    @IBOutlet weak var remain: checkbox!
    //    @IBOutlet weak var check: checkbox!
    @IBOutlet weak var testtxt: UITextView!
    
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Account: UILabel!
    @IBOutlet weak var Accounttxt: UITextField!
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var test: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // login function
    @IBAction func CheckLoginData(sender: AnyObject) {
        //defination
        var token:Int = 0;
        let alertController = UIAlertController(title: "Error", message: "Please check your account or password again.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        //implement login
        
        Alamofire.request(.POST, "http://bingo.villager.website/users/login", parameters:
            ["user":["account": Accounttxt.text!, "password": Passwordtxt.text!]])
            .responseJSON {
                response in
                token = response.result.value as! Int
                if(token != 0){
                    self.Userid = token
                    self.performSegueWithIdentifier("toGameMainView", sender: self)
     
                }
                else{
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }

    }
   
    //passing Userid to GameMainView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGameMainView" {
            let destinationController =  segue.destinationViewController as! GameMainViewController
            destinationController.Userid = self.Userid
        }
    }
    // Register function
    @IBAction func RegisterBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("toRegisterView", sender: self)
//        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterView")  as! RegisterViewController
//        self.presentViewController(ctrl, animated: true, completion: nil)
        
    }
    
    @IBAction func test(sender: AnyObject) {
        self.performSegueWithIdentifier("toGameMainView", sender: self)
    }
    
    
}
