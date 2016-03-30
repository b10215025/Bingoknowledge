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
                     print("!!!! \(response.result.value)")
                token = response.result.value as! Int
                print("llll  \(token)")
                if(token != 0){
                    //test start
                    self.Userid = token
                    //test end
                    self.performSegueWithIdentifier("toGameMainView", sender: self)
                    let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("GameMainView")  as! GameMainViewController
                    self.presentViewController(ctrl, animated: true, completion: nil)
                    
                }
                self.presentViewController(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    //JSON to NSData
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    //NSdata to NSArray
    func parseJSON(inputData: NSData) -> NSArray{
        var boardsDictionary: NSArray = NSArray()
        do {
            boardsDictionary = try NSJSONSerialization.JSONObjectWithData(inputData,  options: NSJSONReadingOptions.MutableContainers) as! NSArray
        } catch  {
            print("Error message:Can't not transfer to NSArray from NSData !")
        }
        return boardsDictionary
    }
    
    //testBtn
    @IBAction func TestBtn(sender: AnyObject) {
        //        var funcA:ProcessJSON = ProcessJSON()
        //        var userdataset = [QuestionSet](count: 10, repeatedValue: QuestionSet.init())
        //        var testarray:NSArray = NSArray()
        //
        //        //use method to process JSON
        //        testarray = funcA.parseJSON(funcA.getJSON("http://bingo.villager.website/exams/output"))
        //        for(var i = 0; i < 10 ;i++){
        //            userdataset[i].id = testarray[i]["id"] as! Int
        //            userdataset[i].Question = testarray[i]["question"] as! String
        //            userdataset[i].Answer = testarray[i]["answer"] as! String
        //            userdataset[i].Tip = testarray[i]["tips"] as! String
        //            userdataset[i].Print_Data()
        //        }
        self.performSegueWithIdentifier("toGameMainView", sender: self)
        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("GameMainView")  as! GameMainViewController
        self.presentViewController(ctrl, animated: true, completion: nil)
        
        
    }
    //passing Userid to GameMainView
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGameMainView" {
            let destinationController =  segue.destinationViewController as! GameMainViewController
            destinationController.Userid = self.Userid
            //print(self.value)
            
        }
    }
    
    @IBAction func RegisterBtn(sender: AnyObject) {
        self.performSegueWithIdentifier("toRegisterView", sender: self)
        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterView")  as! RegisterViewController
        self.presentViewController(ctrl, animated: true, completion: nil)
        
    }
    
    
}
