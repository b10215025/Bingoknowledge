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

    var testset:QuestionSet = QuestionSet.init()
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var birthday_txt: UITextField!
    @IBOutlet weak var Passwordagain_txt: UITextField!
    @IBOutlet weak var Password_txt: UITextField!
    @IBOutlet weak var Account_txt: UITextField!
   
    @IBOutlet weak var RegistersubmitBtn: UIButton!
    
    @IBOutlet weak var register_background: UIImageView!

    @IBOutlet weak var Identity_Teacher: checkbox!
    @IBOutlet weak var Identity_Student: checkbox_student!
    @IBOutlet weak var ClearBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(register_background)
        Account_txt.layer.cornerRadius = CGFloat(Float(15.0))
        Password_txt.layer.cornerRadius = CGFloat(Float(15.0))
        Passwordagain_txt.layer.cornerRadius = CGFloat(Float(15.0))
        birthday_txt.layer.cornerRadius = CGFloat(Float(15.0))
        
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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
        let RegisterAlert = UIAlertController(title: "警告", message: "帳號已有人使用", preferredStyle: UIAlertControllerStyle.Alert)
        RegisterAlert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        
        let Emptyalert = UIAlertController(title: "警告", message: "資料未填寫確實", preferredStyle: UIAlertControllerStyle.Alert)
        Emptyalert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        let IdentityAlert = UIAlertController(title: "警告", message: "尚未選取您的身份", preferredStyle: UIAlertControllerStyle.Alert)
        IdentityAlert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        
        let NotTheSamealert = UIAlertController(title: "警告", message: "請確認您的密碼和確認密碼是否相同", preferredStyle: UIAlertControllerStyle.Alert)
        NotTheSamealert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        
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
        
        //adding account to Database
        if(qualified){
            self.activity.startAnimating()
            self.RegistersubmitBtn.enabled = false
            self.ClearBtn.enabled = false

            Alamofire.request(.POST, "http://bingo.villager.website/users", parameters:
                ["user":["account": Account_txt.text! , "password": Password_txt.text! , "birthday": birthday_txt.text! , "identity": Identity]])
                .responseJSON { response in
                    var result = response.result.value
                    if((result) != nil){
                        token = result as! Bool
                        print(token)
                        if(token){
                            if let navController = self.navigationController {
                                self.activity.stopAnimating()
                                self.RegistersubmitBtn.enabled = true
                                self.ClearBtn.enabled = true
                                navController.popViewControllerAnimated(true)
                            }
                        }
                        self.activity.stopAnimating()
                        self.RegistersubmitBtn.enabled = true
                        self.ClearBtn.enabled = true
                        self.presentViewController(RegisterAlert, animated: true, completion: nil)
                    }else{
                        self.activity.stopAnimating()
                        self.RegistersubmitBtn.enabled = true
                        self.ClearBtn.enabled = true
                        let connecttdController = UIAlertController(title: "連線失敗", message: "請確認網路是否已連線", preferredStyle: UIAlertControllerStyle.Alert)
                        connecttdController.addAction(UIAlertAction(title: "確定", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(connecttdController, animated: true, completion: nil)

                    }
                    
                    
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
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
}
