//
//  RegisterViewController.swift
//  Bingo_ver1
//
//  Created by killerhi2001 on 2016/3/21.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
//    @IBOutlet weak var ClearBtn: UIButton!
        var testset:QuestionSet = QuestionSet.init()
    
    @IBOutlet weak var birthday_txt: UITextField!
    @IBOutlet weak var Passwordagain_txt: UITextField!
    @IBOutlet weak var Password_txt: UITextField!
    @IBOutlet weak var Account_txt: UITextField!
   
    @IBOutlet weak var back: UIButton!

    @IBOutlet weak var Identity_Teacher: checkbox!
    @IBOutlet weak var Identity_Student: checkbox!
    @IBOutlet weak var ClearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Register Action
    @IBAction func RegisterBtn_clicked(sender: AnyObject) {
        var token:Bool = false
        var Identity:String = ""
        var qualified:Bool = true
        
        //Define AlertController
        let RegisterAlert = UIAlertController(title: "Warming", message: "Please change a new account.", preferredStyle: UIAlertControllerStyle.Alert)
        RegisterAlert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        let Emptyalert = UIAlertController(title: "Warming", message: "Please filled the data.", preferredStyle: UIAlertControllerStyle.Alert)
        Emptyalert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        let IdentityAlert = UIAlertController(title: "Warming", message: "Please chose your identity.", preferredStyle: UIAlertControllerStyle.Alert)
        IdentityAlert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        let NotTheSamealert = UIAlertController(title: "Warming", message: "Please checked password again.", preferredStyle: UIAlertControllerStyle.Alert)
        NotTheSamealert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        //check for empty textfield
        if( Account_txt.text == ""  || Password_txt.text == "" || Passwordagain_txt.text == "" || birthday_txt.text == "" || (Identity_Student.isChecked == false && Identity_Teacher == false) ){
            presentViewController(Emptyalert, animated: true, completion: nil)
            qualified = false;
        }
        //check identity is selected
        if(Identity_Teacher.isChecked == false && Identity_Student.isChecked == false){
            presentViewController(IdentityAlert, animated: true, completion: nil)
            qualified = false;
        }
        
        //check if password match
        if(Password_txt.text != Passwordagain_txt.text){
            presentViewController(NotTheSamealert, animated: true, completion: nil)
            qualified = false;
        }
        //determine identity value
        if(Identity_Teacher.isChecked == true){
            Identity = "teacher";
        }
        else{
            Identity = "student";
        }
        print("id:  \(Identity)")
        //adding account to Database
        if(qualified){
            Alamofire.request(.POST, "http://bingo.villager.website/users", parameters:
                ["user":["account": Account_txt.text! , "password": Password_txt.text! , "birthday": birthday_txt.text! , "identity": Identity]])
                .responseJSON { response in
                    print(token)
                    token = response.result.value as! Bool
                    if(token){
//                        self.performSegueWithIdentifier("returnLoginView", sender: self)
//                        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView")  as! LoginViewController
//                        self.presentViewController(ctrl, animated: true, completion: nil)
                        if let navController = self.navigationController {
                            navController.popViewControllerAnimated(true)
                        }
                    }
                    self.presentViewController(RegisterAlert, animated: true, completion: nil)
            }
        }
    }
    // ClearBtn Action
    @IBAction func ClearBtn_clicked(sender: AnyObject) {
        Account_txt.text = ""
        Password_txt.text = ""
        Passwordagain_txt.text = ""
        birthday_txt.text = ""
        Identity_Teacher.setImage(Identity_Teacher.unCheckedImage, forState: .Normal)
        Identity_Teacher.isChecked = false
        Identity_Student.setImage(Identity_Student.unCheckedImage, forState: .Normal)
        Identity_Student.isChecked = false
    }
    //set allow chose one identity
    @IBAction func OnlyId(sender: checkbox) {
        //let another button unchecked
        if(sender == Identity_Student){
            Identity_Teacher.setImage(Identity_Teacher.unCheckedImage, forState: .Normal)
            Identity_Teacher.isChecked = false
        }
        if(sender == Identity_Teacher){
            Identity_Student.setImage(Identity_Student.unCheckedImage, forState: .Normal)
            Identity_Student.isChecked = false
        }
        
    }

    @IBAction func TextFieldDone(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    @IBAction func backgroundtap(sender: AnyObject) {
        Account_txt.resignFirstResponder()
        Password_txt.resignFirstResponder()
        Passwordagain_txt.resignFirstResponder()
        birthday_txt.resignFirstResponder()
    }
    
//    @IBAction func back_clicked(sender: AnyObject) {
//        self.performSegueWithIdentifier("returnLoginView", sender: self)
//        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("LoginView")  as! LoginViewController
//        self.presentViewController(ctrl, animated: true, completion: nil)
//    }
//    
}
