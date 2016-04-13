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
    var Identity:String = ""
    
    
    @IBOutlet weak var background_image: UIImageView!
    @IBOutlet weak var remain: checkbox!
    //    @IBOutlet weak var check: checkbox!
    @IBOutlet weak var testtxt: UITextView!
    
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Account: UILabel!
    @IBOutlet weak var Accounttxt: UITextField!
    @IBOutlet weak var Passwordtxt: UITextField!
    @IBOutlet weak var Login: UIButton!
    @IBOutlet weak var RegisterBtn: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(background_image)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // login function
    @IBAction func CheckLoginData(sender: AnyObject) {
        //defination
        
        let alertController = UIAlertController(title: "登入失敗", message: "請確認您的帳密是否有輸入錯誤", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        //implement login
        
        Alamofire.request(.POST, "http://bingo.villager.website/users/login", parameters:
            ["user":["account": Accounttxt.text!, "password": Passwordtxt.text!]])
            .responseJSON {
                response in
                var token = response.result.value
                if((token) != nil ){
                    self.Userid = token?.objectForKey("user_id") as! Int
                    if(self.Userid != 0){
                        self.Identity = token!["identity"] as! String
                        self.performSegueWithIdentifier("toGameMainView", sender: self)
                    }
                    else{
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                }else{
                    let connecttdController = UIAlertController(title: "連線失敗", message: "請確認網路是否已連線", preferredStyle: UIAlertControllerStyle.Alert)
                    connecttdController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(connecttdController, animated: true, completion: nil)
                }
        }

    }
   
    //passing Userid to GameMainView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGameMainView" {
            let destinationController =  segue.destinationViewController as! GameMainViewController
            destinationController.Userid = self.Userid
            destinationController.Identity = self.Identity
        }
    }
    // Register function
    @IBAction func RegisterBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("toRegisterView", sender: self)
    }
  
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func TextFieldDone(sender: AnyObject) {
    
        sender.resignFirstResponder()
    }
}
