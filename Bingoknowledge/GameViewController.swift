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
    //Search function
    @IBAction func SearchBtn_clicked(sender: AnyObject) {
        var QuestionSetNum : String = ""
        // user enter teacherID to search QuestionSetNum
        var SearchAlert:UIAlertController = UIAlertController(title: "查詢頁面", message:"請輸入教師ID" , preferredStyle: UIAlertControllerStyle.Alert)
        SearchAlert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "教師ID"
        }
        //request sever and show result after user enter teacherID
        let submit = UIAlertAction(title: "查詢", style: UIAlertActionStyle.Default , handler: {
            action in
                //read user enter userid
                let Teacher_id = (SearchAlert.textFields!.first! as UITextField).text!
                //request sever
                Alamofire.request(.GET, "http://bingo.villager.website/exams/search",parameters:["user_id": Teacher_id ]).responseJSON {response in
                        var result = response.result.value
                        //use UIAlertcontroller show result
                        if(result != nil && result?.count != 0){
                            for var i in 0..<Int((result?.count)!) {
                                QuestionSetNum += String("\(result![i])，")
                            }
                            var ShowAlert:UIAlertController = UIAlertController(title: "查詢結果", message:  "教師編號:\(Teacher_id) \n 所有題組編號：\n{ \(QuestionSetNum)}" , preferredStyle: UIAlertControllerStyle.Alert)
                            ShowAlert.addAction(UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(ShowAlert, animated: true, completion: nil)
                        }
                        else{
                            var errorAlert:UIAlertController = UIAlertController(title: "查詢結果", message:  "您所查詢之ID尚未創建任何題組" , preferredStyle: UIAlertControllerStyle.Alert)
                            errorAlert.addAction(UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(errorAlert, animated: true, completion: nil)
                        }
                }
        })
        SearchAlert.addAction(submit)
        presentViewController(SearchAlert, animated: true, completion: nil)
    }

        
        
}


