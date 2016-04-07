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
    var UserQuestionSet:QuestionSet = QuestionSet.init()
    var token = 0
    var Userid = 0
    
    @IBOutlet weak var Userid_Label: UILabel!
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet var QuestionBtnArray: [UIButton]!
    @IBOutlet weak var BingocheckBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print(QuestionBtnArray.count)
        print(UserQuestionSet.id[0])
        Userid_Label.text = String(self.Userid)
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }

    
    @IBAction func bingoBtnClicked(sender: UIButton) {
        var  BingoAlert:UIAlertController = UIAlertController(title: "訊息", message: "您還未達成連線，加油！", preferredStyle: UIAlertControllerStyle.Alert)
        BingoAlert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        

        if isBingo(UserQuestionSet) {
            //do sth
            self.performSegueWithIdentifier("toResultView", sender: self)
                  

        }
        else{
            //do sth else
             self.presentViewController(BingoAlert, animated: true, completion: nil)
        }
    }
    //Question Clicked
    @IBAction func QuestionBtn_clicked(sender: AnyObject) {
        self.token = sender.tag
        if(self.token < 25 && self.token >= 0){
            self.performSegueWithIdentifier("toQuestionPageView", sender: self)
        }
    }
//    
//    
//    @IBAction func backBtn_clicked(sender: AnyObject) {
//        self.performSegueWithIdentifier("returnGameView", sender: self)
//        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("GameView")  as! GameViewController
//        self.presentViewController(ctrl, animated: true, completion: nil)
//    }

    //pass data to QuestionPage
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "toQuestionPageView" {
            let destinationController =  segue.destinationViewController as! QuestionPageViewContorller
            destinationController.QuestionArray = self.UserQuestionSet
            destinationController.QuestionNumber = self.token
            destinationController.delegate = self
        }
    }
    //pass data back from QuestionPage
    func PassDataBack(UserQuestionArray:QuestionSet,QuestionNum:Int){
        self.UserQuestionSet = UserQuestionArray
        let checkedImage = UIImage(named: "checked_checkbox")
        self.QuestionBtnArray[QuestionNum].setImage(checkedImage, forState: .Normal)
        self.QuestionBtnArray[QuestionNum].enabled = false
    }
    
 
//<<<<<<< HEAD
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
//>>>>>>> 016ea1341e39e6d235f25b6d3457fdb4526ffcb2
    
}
