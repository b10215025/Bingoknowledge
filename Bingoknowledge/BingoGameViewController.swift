//
//  BingoGameView.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class BingoGameViewContorller: UIViewController {
    var UserQuestionArray = [QuestionSet]()
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var QuestionBtn1: UIButton!
    @IBOutlet weak var QuestionBtn2: UIButton!
    @IBOutlet weak var testBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //--test load question from server
        var funcA:ProcessJSON = ProcessJSON()
        var userdataset = [QuestionSet](count: 10, repeatedValue: QuestionSet.init())
        var testarray:NSArray = NSArray()
        
        //use method to process JSON
        testarray = funcA.parseJSON(funcA.getJSON("http://bingo.villager.website/exams/output"))
        for(var i = 0; i < 10 ;i++){
            userdataset[i].id = testarray[i]["id"] as! Int
            userdataset[i].Question = testarray[i]["question"] as! String
            userdataset[i].Answer = testarray[i]["answer"] as! String
            userdataset[i].Tip = testarray[i]["tips"] as! String
        }
        self.UserQuestionArray = userdataset
        //--test end
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //testbtn action
    @IBAction func testBtn_clicked(sender: AnyObject) {
        for(var i=0;i<self.UserQuestionArray.count;i++){
            self.UserQuestionArray[i].Print_Data()
        }
        
    }
    //Question Clicked
    @IBAction func QuestionBtn_clicked(sender: AnyObject) {
        var token = sender.tag

        switch(token){
            case 1:
                self.performSegueWithIdentifier("toQuestionPageView", sender: self)
                let ctrl = self.storyboard?.instantiateViewControllerWithIdentifier("QuestionPageView")  as! QuestionPageViewContorller
                self.presentViewController(ctrl, animated: true, completion: nil)
            default:
                print("error message!")
        }
    
    }

    @IBAction func backBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("returnGameView", sender: self)
        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("GameView")  as! GameViewController
        self.presentViewController(ctrl, animated: true, completion: nil)

    }
  
}
