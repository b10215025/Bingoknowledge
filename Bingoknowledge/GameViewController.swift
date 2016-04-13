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
    //gamemodel is used to identity singlegame or onlinegame
    var Gamemodel:Int = 0
    var Userid = 0
    
    @IBOutlet weak var Gameview_background: UIImageView!
    @IBOutlet weak var SingleGameBtn: UIButton!
    @IBOutlet weak var OnlineGameBtn: UIButton!
    @IBOutlet weak var Userid_label: UILabel!
    @IBOutlet weak var SearchBtn: UIButton!
    
    @IBOutlet weak var SearchRankBtn: UIButton!
       override func viewDidLoad() {
        super.viewDidLoad()
        Userid_label.text = String(self.Userid)
          view.sendSubviewToBack(Gameview_background)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SingleGameBtn_clicked(sender: AnyObject) {
        // --load Question from server
        var userdataset:QuestionSet = QuestionSet.init()
        var errorAlert:UIAlertController = UIAlertController(title: "Error", message:  "系統忙碌中" , preferredStyle: UIAlertControllerStyle.Alert)
        errorAlert.addAction(UIAlertAction(title: "確認", style: UIAlertActionStyle.Default, handler: nil))
        
        Alamofire.request(.GET, "http://bingo.villager.website/game_records/print_record",parameters: ["user_id" : self.Userid] ).responseJSON {response in
                var result = response.result.value
            
                if((result) != nil){
                    var questiondata = result!["exam"] as! NSArray
                    var answered  = result!["situation"] as! NSArray
                    
                    var  savaAlert:UIAlertController = UIAlertController(title: "系統訊息", message: "系統內有您的存檔紀錄，是否讀取存檔？", preferredStyle: UIAlertControllerStyle.Alert)
                    let readrecord = UIAlertAction(title: "是", style: UIAlertActionStyle.Default , handler: {
                        action in
                        for var i in 0..<questiondata.count{
                            userdataset.id[i] = questiondata[i]["id"] as! Int
                            userdataset.Question[i] = questiondata[i]["question"] as! String
                            userdataset.Answer[i] = questiondata[i]["answer"] as! String
                            userdataset.Tip[i] = questiondata[i]["tips"] as! String
                            if(answered[i] as! String == "0"){
                                userdataset.isAnswered[i] = false
                            }
                            else{
                                userdataset.isAnswered[i] = true
                            }
                        }
                        self.UserQuestionArray = userdataset;
                        Alamofire.request(.POST, "http://bingo.villager.website/game_records", parameters:
                            ["game_record": [  "user_id" : self.Userid , "delete" : true ]])
                            .responseJSON {
                                response in
                                var isdelete = response.result.value
                                
                                if(isdelete != nil){
                                    self.performSegueWithIdentifier("toBingoGameView", sender: self)
                                }else{
                                    self.presentViewController(errorAlert, animated: true, completion: nil)
                                }
                        }
                    })
                    savaAlert.addAction(readrecord)
                    // if doesn't want to read save record then delete the record and restart a new game
                    savaAlert.addAction(UIAlertAction(title: "否", style: UIAlertActionStyle.Default, handler: {
                        action in
                        Alamofire.request(.POST, "http://bingo.villager.website/game_records", parameters:
                            ["game_record": [  "user_id" : self.Userid , "delete" : true ]])
                            .responseJSON {
                                response in
                                var isdelete = response.result.value
                                
                                if(isdelete != nil){
                                    //read record data
                                    Alamofire.request(.GET, "http://bingo.villager.website/exams/output").responseJSON {response in
                                        var result = response.result.value
                                        if (result != nil){
                                            
                                            for var i in 0..<result!.count{
                                                userdataset.id[i] = result![i]["id"] as! Int
                                                userdataset.Question[i] = result![i]["question"] as! String
                                                userdataset.Answer[i] = result![i]["answer"] as! String
                                                userdataset.Tip[i] = result![i]["tips"] as! String
                                                
                                            }
                                            
                                            self.UserQuestionArray = userdataset;
                                            
                                            self.performSegueWithIdentifier("toBingoGameView", sender: self)
                                        }
                                        else{
                                            self.presentViewController(errorAlert, animated: true, completion: nil)
                                        }
                                    }
                                }
                                else{
                                    var ErrorAddScoreAlert:UIAlertController = UIAlertController(title: "連線失敗", message:"請確認您已連上線" , preferredStyle: UIAlertControllerStyle.Alert)
                                    ErrorAddScoreAlert.addAction(UIAlertAction(title: "確認", style: .Default, handler: nil))
                                    self.presentViewController(ErrorAddScoreAlert, animated: true, completion: nil)
                                }
                        }
                    }))
                    self.presentViewController(savaAlert, animated: true, completion: nil)
                }
                else{
                    Alamofire.request(.GET, "http://bingo.villager.website/exams/output").responseJSON {response in
                        var result = response.result.value
                        if (result != nil){
                            
                            for var i in 0..<result!.count{
                                userdataset.id[i] = result![i]["id"] as! Int
                                userdataset.Question[i] = result![i]["question"] as! String
                                userdataset.Answer[i] = result![i]["answer"] as! String
                                userdataset.Tip[i] = result![i]["tips"] as! String
                                
                            }
                            
                            self.UserQuestionArray = userdataset;
                            self.performSegueWithIdentifier("toBingoGameView", sender: self)
                        }
                        else{
                            self.presentViewController(errorAlert, animated: true, completion: nil)
                        }
                    }
                    
                }
        }
    }

    //Online function
    @IBAction func OnlineGameBtn_clicked(sender: AnyObject) {
//        var room_id = 0
        self.Gamemodel = 1
        var TestQuestionSet:QuestionSet = QuestionSet.init()
        
        var SearchAlert:UIAlertController = UIAlertController(title: "線上模式", message:"請輸入題組代號" , preferredStyle: UIAlertControllerStyle.Alert)
        SearchAlert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "題組代號"
        }
        let submit = UIAlertAction(title: "進入", style: UIAlertActionStyle.Default , handler: {
            action in
            //read user enter userid
            let room_id = (SearchAlert.textFields!.first! as UITextField).text!
            //request sever
            Alamofire.request(.GET, "http://bingo.villager.website/exams/print_exam_set",parameters:["exam_set_id": room_id ]).responseJSON {response in
                
                var result = response.result.value
                //use UIAlertcontroller show result
                
                if(result != nil && result?.count != 0){
                    var QuestionArray = [String]()
                    var AnswerArray = [String]()
                    var TipArray = [String]()
                    var idArray = [String]()
                    print(result)
                    QuestionArray = (result?.objectForKey("question"))! as! [String]
                    AnswerArray = (result?.objectForKey("answer"))! as! [String]
                    TipArray = (result?.objectForKey("tips"))! as! [String]
//                    idArray = (result?.objectForKey("id")
                    for var i in 0..<25{
                        TestQuestionSet.Question[i] = QuestionArray[i]
                        TestQuestionSet.Answer[i] = AnswerArray[i]
                        TestQuestionSet.Tip[i] = TipArray[i]
                    }
                    self.UserQuestionArray = TestQuestionSet
                    print(self.UserQuestionArray)
                    self.performSegueWithIdentifier("toBingoGameView", sender: self)
                }
                else{
                    var errorAlert:UIAlertController = UIAlertController(title: "查詢結果", message:  "系統查無此題組" , preferredStyle: UIAlertControllerStyle.Alert)
                    errorAlert.addAction(UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
            }
        })
        
        SearchAlert.addAction(submit)
        presentViewController(SearchAlert, animated: true, completion: nil)
        
    }
//    //Search QuestionSetNumber function
    @IBAction func SearchBtn_clicked(sender: AnyObject) {
        var result_print:String = ""
        var RoomidArray = [Int]()
        var RoomnameArray = [String]()
        // user enter teacherID to search QuestionSetNum
        var SearchAlert:UIAlertController = UIAlertController(title: "查詢頁面", message:"請輸入教師編號" , preferredStyle: UIAlertControllerStyle.Alert)
        SearchAlert.addTextFieldWithConfigurationHandler {
            (textField: UITextField! ) -> Void in
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
                 
                        if(result != nil && result!["id"]!!.count != 0){
                            RoomidArray = result?.objectForKey("id") as! [Int]
                            RoomnameArray = result?.objectForKey("name") as! [String]
                            for var i in 0..<Int(RoomidArray.count) {
                                result_print = result_print + "題組代號:\(RoomidArray[i]) 主題:\(RoomnameArray[i])\n"
                            }
                            var ShowAlert:UIAlertController = UIAlertController(title: "查詢結果", message:  "教師編號:\(Teacher_id)已創建\(Int((result!["id"]?!.count)!))組題組\n\(result_print)如想進入題組請記下題組代號\n前往線上模式輸入編號即可進入！" , preferredStyle: UIAlertControllerStyle.Alert)
                            ShowAlert.addAction(UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(ShowAlert, animated: true, completion: nil)
                        }
                        else{
                            var errorAlert:UIAlertController = UIAlertController(title: "查無匹配結果", message:  "該位教師尚未創建任何題組或系統內無此教師資訊" , preferredStyle: UIAlertControllerStyle.Alert)
                            errorAlert.addAction(UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: nil))
                            self.presentViewController(errorAlert, animated: true, completion: nil)
                        }
                }
        })
        SearchAlert.addAction(submit)
        presentViewController(SearchAlert, animated: true, completion: nil)
    }
    //SearchRank function
    @IBAction func SearchRankBtn_clicked(sender: AnyObject) {
        var Account = [String]()
        var Score = [Int]()
        var print_result : String = "------top 20------\n"

        Alamofire.request(.GET, "http://bingo.villager.website/users/ranking" ).responseJSON {response in
            var result = response.result.value

            if((result ) != nil){
                Account = [String](count: (result!.count) as! Int , repeatedValue: "")
                Score = [Int](count: (result!.count) as! Int , repeatedValue: 0)
                
                for var i in 0 ..< Int(result!.count) {
                    Account[i] = result![i]["account"] as! String
                    Score[i] = result![i]["score"] as! Int
                    print_result = print_result + "  第\(i+1)名 帳號ID:\(Account[i])總積分：\(Score[i])\n"
                }
                var RankAlert:UIAlertController = UIAlertController(title: "排行榜", message:"\(print_result)" , preferredStyle: UIAlertControllerStyle.Alert)
                RankAlert.addAction(UIAlertAction(title: "確認", style: .Default, handler: nil))
                self.presentViewController(RankAlert, animated: true, completion: nil)
                
            }
            
        }
    
        
    }
    
    
    
    
    // pass Question data to BingoGame
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toBingoGameView" {
            let destinationController =  segue.destinationViewController as! BingoGameViewContorller
            destinationController.UserQuestionSet = self.UserQuestionArray
            destinationController.Userid = self.Userid
            destinationController.gameModel = self.Gamemodel
        }
    }
    
    @IBAction func testBtn(sender: AnyObject) {
    }
}


