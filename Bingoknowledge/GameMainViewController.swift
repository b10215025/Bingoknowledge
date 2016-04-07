//
//  GameMainViewControlle/Users/killerhi2001/Documents/ios_workspace/Bingo_ver1/Bingo_ver1/GameMainViewController.swiftr.swift
//  Bingo_ver1
//
//  Created by killerhi2001 on 2016/3/17.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
import Alamofire

//import

class GameMainViewController: UIViewController {
    var Userid = 0
    var Identity:String = ""
    
    @IBOutlet weak var back: UIButton!
    
    @IBOutlet weak var TeacherSetTheme: UIButton!
  
    
    @IBOutlet weak var NextPageBtn: UIButton!
    
    @IBOutlet weak var Testlabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Testlabel.text = "Userid: \(Userid)"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("returnLoginView", sender: self)
        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("LoginView")  as! LoginViewController
        self.presentViewController(ctrl, animated: true, completion: nil)
        
    }
    @IBAction func NextPageBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("toGameView", sender: self)
    }
    
    @IBAction func TeacherSetTheme_clicked(sender: AnyObject) {
        let errorAlert = UIAlertController(title: "警告", message: "您的權限不足，無法進入", preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        if(self.Identity == "teacher"){
            self.performSegueWithIdentifier("toSetThemeView", sender: self)
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Please check your account or password again.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(errorAlert, animated: true, completion: nil)
        }
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toGameView" {
            let destinationController =  segue.destinationViewController as! GameViewController
            destinationController.Userid = self.Userid            
        }
        
        if segue.identifier == "toSetThemeView" {
                let destinationController =  segue.destinationViewController as! SetThemeViewController
                destinationController.Userid = self.Userid
        }
        
    }
    @IBAction func testBtn_clicked(sender: AnyObject) {
    }
}
