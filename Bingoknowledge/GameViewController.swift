//
//  GameViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
import Alamofire
class GameViewController: UIViewController {
    //    var UserQuestionArray = [QuestionSet](count: 10, repeatedValue: QuestionSet.init())
    //test class 3/28
    var UserQuestionArray:QuestionSet = QuestionSet.init()
    var Userid = 0
    
    @IBOutlet weak var SingleGameBtn: UIButton!
    @IBOutlet weak var OnlineGameBtn: UIButton!
    @IBOutlet weak var Userid_label: UILabel!
    @IBOutlet weak var SearchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Userid_label.text = String(self.Userid)
        // --load Question from server
        var funcA:ProcessJSON = ProcessJSON()
        var userdataset:QuestionSet = QuestionSet.init()
        var testarray:NSArray = NSArray()
        
        //use method to process JSON
        testarray = funcA.parseJSON(funcA.getJSON("http://bingo.villager.website/exams/output"))
        
        //read data 
        for var i in 0..<10 {
            userdataset.id[i] = testarray[i]["id"] as! Int
            userdataset.Question[i] = testarray[i]["question"] as! String
            userdataset.Answer[i] = testarray[i]["answer"] as! String
            userdataset.Tip[i] = testarray[i]["tips"] as! String
        }
        self.UserQuestionArray = userdataset
        //--end
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SingleGameBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("toBingoGameView", sender: self)
    }
    // pass Question data to BingoGame
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toBingoGameView" {
            let destinationController =  segue.destinationViewController as! BingoGameViewContorller
            destinationController.UserQuestionSet = self.UserQuestionArray
            destinationController.Userid = self.Userid
        }
    }
    //--test search function
    @IBAction func SearchBtn_clicked(sender: AnyObject) {
  
    }
    //--end
}
