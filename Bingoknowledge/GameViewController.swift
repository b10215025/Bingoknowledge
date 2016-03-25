//
//  GameViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var SingleGameBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("returnGameMainView", sender: self)
        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("GameMainView")  as! GameMainViewController
        self.presentViewController(ctrl, animated: true, completion: nil)
    }

    @IBAction func SingleGameBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("toBingoGameView", sender: self)
        let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("BingoGameView")  as! BingoGameViewContorller
        self.presentViewController(ctrl, animated: true, completion: nil)
    }

}
