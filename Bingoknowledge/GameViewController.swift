//
//  GameViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
//    var UserQuestionArray = [QuestionSet](count: 10, repeatedValue: QuestionSet.init())
    //test class 3/28
    var UserQuestionArray:QuestionSet = QuestionSet.init()
    var Userid = 0
    
    @IBOutlet weak var SingleGameBtn: UIButton!
    @IBOutlet weak var Userid_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Userid_label.text = String(self.Userid)
        // --test load question from server
                var funcA:ProcessJSON = ProcessJSON()
                var userdataset:QuestionSet = QuestionSet.init()
                var testarray:NSArray = NSArray()
        
                //use method to process JSON
                testarray = funcA.parseJSON(funcA.getJSON("http://bingo.villager.website/exams/output"))
                for(var i = 0; i < 10 ;i++){
                    userdataset.id[i] = testarray[i]["id"] as! Int
                    userdataset.Question[i] = testarray[i]["question"] as! String
                    userdataset.Answer[i] = testarray[i]["answer"] as! String
                    userdataset.Tip[i] = testarray[i]["tips"] as! String
                }
                self.UserQuestionArray = userdataset
        //--test end
        print(UserQuestionArray.id[2])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
  
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toBingoGameView" {
            let destinationController =  segue.destinationViewController as! BingoGameViewContorller
            // test 3/28
            destinationController.UserQuestionSet = self.UserQuestionArray
            destinationController.Userid = self.Userid
        }
    }

}
