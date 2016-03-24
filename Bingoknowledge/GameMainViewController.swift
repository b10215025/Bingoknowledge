//
//  GameMainViewControlle/Users/killerhi2001/Documents/ios_workspace/Bingo_ver1/Bingo_ver1/GameMainViewController.swiftr.swift
//  Bingo_ver1
//
//  Created by killerhi2001 on 2016/3/17.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
//import

class GameMainViewController: UIViewController {
    @IBOutlet weak var back: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnBtn_clicked(sender: AnyObject) {
        //        let Emptyalert = UIAlertController(title: "Warming", message: "Please filled the data.", preferredStyle: UIAlertControllerStyle.Alert)
        //        Emptyalert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.performSegueWithIdentifier("ReturnLoginView", sender: self)
        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("LoginView")  as! ViewController
        self.presentViewController(ctrl, animated: true, completion: nil)
        
    }

}
