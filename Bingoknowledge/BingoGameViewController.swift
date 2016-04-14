//
//  BingoGameView.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
import Alamofire

class BingoGameViewContorller: UIViewController ,Myprotocol{
//    var UserQuestionArray1 = [QuestionSet]()
    @IBOutlet weak var bingo_background: UIImageView!
    var gameModel:Int = 0
    var UserQuestionSet:QuestionSet = QuestionSet.init()
    var token = 0
    var Userid = 0
    var score:Int = 0
    var totolscore:Int = 0
    
    
    @IBOutlet weak var Userid_Label: UILabel!
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet var QuestionBtnArray: [UIButton]!
    @IBOutlet weak var BingocheckBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.sendSubviewToBack(bingo_background)
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Bordered, target: self, action: "back:")
        self.navigationItem.leftBarButtonItem = newBackButton;
        Userid_Label.text = String(self.Userid)
        //for have single game history record set isanswered image
        if(gameModel == 0 ){
            for var i in 0..<UserQuestionSet.id.count{
                if(UserQuestionSet.isAnswered[i] == true){
                    if(i % 2 == 0){
                        self.QuestionBtnArray[i].setImage(UIImage(named: "shot_pink"), forState: .Normal)
                    }
                    else{
                        self.QuestionBtnArray[i].setImage(UIImage(named: "shot_yellow"), forState: .Normal)
                        
                    }
                }
            }
        }

    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    
    @IBAction func bingoBtnClicked(sender: UIButton) {
        var  BingoAlert:UIAlertController = UIAlertController(title: "訊息", message: "您還未達成連線，加油！", preferredStyle: UIAlertControllerStyle.Alert)
        BingoAlert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        // if bingo then addscore and to ResultviewPage
        if isBingo(UserQuestionSet) {
            //do sth
            
            Alamofire.request(.POST , "http://bingo.villager.website/users/add_score", parameters:["user": ["user_id" : self.Userid, "score" : score]])
                .responseJSON {
                    response in
                    var result = response.result.value
                    
                    self.totolscore = result!["score"] as! Int
                    
                    Alamofire.request(.POST, "http://bingo.villager.website/game_records", parameters:
                        ["game_record": [  "user_id" : self.Userid , "delete" : true ]])
                        .responseJSON {
                            response in
                            var result = response.result.value
                            
                            if(result != nil){
                                self.performSegueWithIdentifier("toResultView", sender: self)
                                
                            }
                            else{
                                var ErrorAddScoreAlert:UIAlertController = UIAlertController(title: "連線失敗", message:"請確認您已連上線" , preferredStyle: UIAlertControllerStyle.Alert)
                                ErrorAddScoreAlert.addAction(UIAlertAction(title: "確認", style: .Default, handler: nil))
                                self.presentViewController(ErrorAddScoreAlert, animated: true, completion: nil)
                            }
                    }
            }
        }
        else{
            //do sth else
             self.presentViewController(BingoAlert, animated: true, completion: nil)
        }
    }
    //Question Clicked
    @IBAction func QuestionBtn_clicked(sender: AnyObject) {
        self.token = sender.tag
        if(self.token < 25 && self.token >= 0 && !UserQuestionSet.isAnswered[sender.tag]){
            self.performSegueWithIdentifier("toQuestionPageView", sender: self)
        }
    }

    //pass data to QuestionPage
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toQuestionPageView" {
            let destinationController =  segue.destinationViewController as! QuestionPageViewContorller
            destinationController.QuestionArray = self.UserQuestionSet
            destinationController.QuestionNumber = self.token
            destinationController.delegate = self
        }
        else if segue.identifier == "toResultView" {
            let destinationController =  segue.destinationViewController as! ResultViewController
            destinationController.score = self.score
            destinationController.totalscore = self.totolscore
        }
    }
    //pass data back from QuestionPage
    func PassDataBack(UserQuestionArray:QuestionSet,QuestionNum:Int){
        self.UserQuestionSet = UserQuestionArray
        if(QuestionNum % 2 == 0){
            self.QuestionBtnArray[QuestionNum].setImage(UIImage(named: "shot_pink"), forState: .Normal)
        }
        else{
            self.QuestionBtnArray[QuestionNum].setImage(UIImage(named: "shot_yellow"), forState: .Normal)

        }
        if(self.score < 21 && gameModel == 0){
            self.score = self.score + self.UserQuestionSet.level[QuestionNum]
        }
        
    }
    
 

// 
//=======
//    
    func isBingo(set: QuestionSet) -> Bool{
        
        let n = Int(sqrt(Double(set.isAnswered.count)))
        var bingoCount = 0, secBingoCount = 0
        
        for var i in 0..<n {
            if set.isAnswered[n * i + i] == true{
                bingoCount += 1
            }
            
            if set.isAnswered[n * i + n - i - 1] == true{
                secBingoCount += 1
            }
        }
        if bingoCount == 0 || secBingoCount == 0{
            return false
        }
        else if bingoCount == n || secBingoCount == n {
            return true
        }
        //checking vert＆hori bingo
        else{
            bingoCount = 0
            secBingoCount = 0
            for var i in 0..<n {
                for var j in 0..<n{
                    if set.isAnswered[j + i * n] == true {
                        bingoCount += 1
                    }
                    if set.isAnswered[i + j * n] == true {
                        secBingoCount += 1
                    }
                }
                if bingoCount == n || secBingoCount == n{
                    return true
                }
                else{
                    bingoCount = 0
                    secBingoCount = 0
                }
            }
        }
        return false
    }
    //back action singlegame provide save fuction but onlinegame
    func back(sender: UIBarButtonItem) {
        var backAlert:UIAlertController = UIAlertController(title: "離開當前頁面", message:"是否存檔" , preferredStyle: UIAlertControllerStyle.Alert)
        let SaveAction = UIAlertAction(title: "存檔", style: .Destructive, handler: {
            action in
            Alamofire.request(.POST, "http://bingo.villager.website/game_records", parameters:
                ["game_record": [ "exam" : self.UserQuestionSet.id ,"situation" : self.UserQuestionSet.isAnswered , "user_id" : self.Userid ]])
                .responseJSON {
                    response in
                    var result = response.result.value
                    if(result != nil){
                         self.navigationController?.popViewControllerAnimated(true)
                    }
            }
        })
        let ExitAction = UIAlertAction(title: "離開", style: UIAlertActionStyle.Default, handler: { action in
            Alamofire.request(.POST, "http://bingo.villager.website/game_records", parameters:
                ["game_record": [  "user_id" : self.Userid , "delete" : true ]])
                .responseJSON {
                    response in
                    var result = response.result.value
            
                    if(result != nil){
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                    
            }

        })
        backAlert.addAction(SaveAction)
        backAlert.addAction(ExitAction)

        //***singlegame provide save fuction but onlinegame
        if(gameModel == 0){
            presentViewController(backAlert, animated: true, completion: nil)
        }
        else{
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
        }
    }

    
}
