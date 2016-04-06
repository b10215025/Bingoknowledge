//
//  SetThemeViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/4/4.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit
import Alamofire
class SetThemeViewController: UIViewController {
    var UserQuestionSet:QuestionSet = QuestionSet.init()
    var QuestionNumber:Int = 0
    var Userid = 0
    @IBOutlet weak var Title_label: UILabel!
    @IBOutlet weak var userid_label: UILabel!
    @IBOutlet weak var QuestionNumber_label: UILabel!
    @IBOutlet weak var Question_label: UILabel!
    @IBOutlet weak var Question_txt: UITextView!
    @IBOutlet weak var Tip_label: UILabel!
    @IBOutlet weak var Tip_txt: UITextView!
    @IBOutlet weak var Answer_label: UILabel!
    @IBOutlet weak var Answer_txt: UITextView!
    
    @IBOutlet weak var PreviousBtn: UIButton!
    
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var ForwardBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userid_label.text = ("\(Userid)")
        QuestionNumber_label.text = "第 \(QuestionNumber + 1) 題"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PreviousBtn_clicked(sender: AnyObject) {
        UserQuestionSet.Question[QuestionNumber] = Question_txt.text
        UserQuestionSet.Tip[QuestionNumber] = Tip_txt.text
        UserQuestionSet.Answer[QuestionNumber] = Answer_txt.text
        
        if(QuestionNumber > 0){
            QuestionNumber = QuestionNumber - 1
        }
        else{
            QuestionNumber = 24
        }
        QuestionNumber_label.text = "第 \(QuestionNumber + 1) 題"
        Question_txt.text = UserQuestionSet.Question[QuestionNumber]
        Tip_txt.text = UserQuestionSet.Tip[QuestionNumber]
        Answer_txt.text = UserQuestionSet.Answer[QuestionNumber]
        
        
    }

    @IBAction func ForwardBtn_clicked(sender: AnyObject) {
        
        UserQuestionSet.Question[QuestionNumber] = Question_txt.text
        UserQuestionSet.Tip[QuestionNumber] = Tip_txt.text
        UserQuestionSet.Answer[QuestionNumber] = Answer_txt.text
        
        if(QuestionNumber > 23){
            QuestionNumber = 0
        }
        else{
            QuestionNumber = QuestionNumber + 1
        }
        QuestionNumber_label.text = "第 \(QuestionNumber + 1) 題"
        Question_txt.text = UserQuestionSet.Question[QuestionNumber]
        Tip_txt.text = UserQuestionSet.Tip[QuestionNumber]
        Answer_txt.text = UserQuestionSet.Answer[QuestionNumber]
        
    }
  
    @IBAction func SubmitBtn_clicked(sender: AnyObject) {
        UserQuestionSet.Question[QuestionNumber] = Question_txt.text
        UserQuestionSet.Tip[QuestionNumber] = Tip_txt.text
        UserQuestionSet.Answer[QuestionNumber] = Answer_txt.text

        let alertController = UIAlertController(title: "Error", message: "Please check your Question again.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        
        //testing upload
        Alamofire.request(.POST, "http://bingo.villager.website/exams", parameters:
            ["exam_set":["question": UserQuestionSet.Question,"tips":UserQuestionSet.Tip,"answer":UserQuestionSet.Answer ,"user_id":Userid]])
            .responseJSON {
                response in
                var value = response.result.value as! Int
                print(value)
                if(value != 0){
                    if let navController = self.navigationController {
                        navController.popViewControllerAnimated(true)
                    }
                }
                else{
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
        }

        //end
        
    }

}
