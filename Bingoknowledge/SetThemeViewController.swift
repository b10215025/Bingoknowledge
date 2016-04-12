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
    @IBOutlet weak var Settheme_background: UIImageView!
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
        view.sendSubviewToBack(Settheme_background)
        

        QuestionNumber_label.text = "第 \(QuestionNumber + 1) 題"
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
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

        let alertController = UIAlertController(title: "確認視窗", message: "為了日後更方便區分\n請為您的題組取一個名稱", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "題組名稱"
        }
        alertController.addAction(UIAlertAction(title: "確認", style: .Destructive ,handler: {action in
            let QuestionSet_name = (alertController.textFields!.first! as UITextField).text!
            print(QuestionSet_name)
            Alamofire.request(.POST, "http://bingo.villager.website/exams", parameters:
                ["exam_set":["question": self.UserQuestionSet.Question,"tips":self.UserQuestionSet.Tip,"answer": self.UserQuestionSet.Answer ,"user_id":self.Userid , "name" : QuestionSet_name]])
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
        }))
        alertController.addAction(UIAlertAction(title: "返回", style: UIAlertActionStyle.Default , handler: nil))
        
        //testing upload
        

        //end
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

}
