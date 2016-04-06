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
<<<<<<< HEAD
<<<<<<< HEAD
    //--test search function
    @IBAction func SearchBtn_clicked(sender: AnyObject) {
  
    }
    //--end
=======
=======
>>>>>>> algorithm
    @IBAction func OnlineGameBtn_clicked(sender: AnyObject) {
        var room_id = 9
        var TestQuestionSet:QuestionSet = QuestionSet.init()
        Alamofire.request(.GET, "http://bingo.villager.website/exams/print_exam_set", parameters:
            ["exam_set_id": room_id ])
            .responseJSON {
                response in
                var result = response.result.value
                var n = Int((result?.count)!)
                
                for var i in 0..<25{
                    TestQuestionSet.Question[i] = result!["question"]!![i] as!  String
                    TestQuestionSet.Answer[i] = result!["answer"]!![i] as!  String
                    TestQuestionSet.Tip[i] = result!["tips"]!![i] as!  String
                    
                }
            print(TestQuestionSet.Question)
            print(TestQuestionSet.Tip)
            print(TestQuestionSet.Answer)
                
        }
        
        
    }
    //--test search function
    @IBAction func SearchBtn_clicked(sender: AnyObject) {
        var Teacher_id :Int = 23
        var idstr : String = ""
        
        var SearchAlert:UIAlertController = UIAlertController(title: "查詢頁面", message:"請輸入教師ID" , preferredStyle: UIAlertControllerStyle.Alert)
<<<<<<< HEAD

        
        SearchAlert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "教師ＩＤ"
        }
        let submit = UIAlertAction(title: "查詢", style: UIAlertActionStyle.Default , handler: { action in
                      idstr = (SearchAlert.textFields!.first! as UITextField).text!
//                    idstr = input.text as! String!
            
        })
        SearchAlert.addAction(submit)
     
        presentViewController(SearchAlert, animated: true, completion: nil)
        //request data from database
        Alamofire.request(.GET, "http://bingo.villager.website/exams/search", parameters:
            ["user_id": Teacher_id ])
            .responseJSON {
                response in
                var result = response.result.value
                var n = Int((result?.count)!)
                for var i in 0..<n {
                    idstr += String("\(result![i]) ")
                }
                print(idstr)
        }
        
    }

        
        
>>>>>>> algorithm
=======

        
        SearchAlert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "教師ＩＤ"
        }
        let submit = UIAlertAction(title: "查詢", style: UIAlertActionStyle.Default , handler: { action in
                      idstr = (SearchAlert.textFields!.first! as UITextField).text!
//                    idstr = input.text as! String!
            
        })
        SearchAlert.addAction(submit)
     
        presentViewController(SearchAlert, animated: true, completion: nil)
        //request data from database
        Alamofire.request(.GET, "http://bingo.villager.website/exams/search", parameters:
            ["user_id": Teacher_id ])
            .responseJSON {
                response in
                var result = response.result.value
                var n = Int((result?.count)!)
                for var i in 0..<n {
                    idstr += String("\(result![i]) ")
                }
                print(idstr)
        }
        
    }

        
        
>>>>>>> algorithm
}
    //--end

