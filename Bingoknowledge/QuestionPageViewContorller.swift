//
//  QuestionPageViewContorller.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class QuestionPageViewContorller: UIViewController {

    var QuestionArray:QuestionSet = QuestionSet.init()
    var QuestionNumber = 0
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var Question_Label: UILabel!
    @IBOutlet weak var SubmitBtn: UIButton!
 
    @IBOutlet weak var Qnumber: UILabel!
    @IBOutlet weak var Question_txt: UITextView!
    @IBOutlet weak var Tip_txt: UITextView!
    @IBOutlet weak var Answer_txt: UITextView!
    @IBOutlet weak var Answer_Label: UILabel!
    @IBOutlet weak var Tip_Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        Question_txt.text = QuestionArray.Question[QuestionNumber]
        Tip_txt.text = QuestionArray.Tip[QuestionNumber]
        Qnumber.text = "\(QuestionNumber)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // compare UserAnswer is same with QuestionAnswer
    @IBAction func SubmitBtn_clicked(sender: AnyObject) {

        if(QuestionArray.Answer[QuestionNumber] == Answer_txt.text){
            self.performSegueWithIdentifier("returnBingoGameView", sender: self)
            let ctrl = storyboard?.instantiateViewControllerWithIdentifier("BingoGameView")  as! BingoGameViewContorller
            self.presentViewController(ctrl, animated: true, completion: nil)
        }
    }
    @IBAction func backBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("returnBingoGameView", sender: self)
        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("BingoGameView")  as! BingoGameViewContorller
        self.presentViewController(ctrl, animated: true, completion: nil)
    }
    
    
    @IBAction func TextFieldDone(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    @IBAction func backgroundtap(sender: AnyObject) {
        Answer_txt.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let checkedImage = UIImage(named: "checked_checkbox")
        if segue.identifier == "toBingiGameView" {
            let destinationController =  segue.destinationViewController as! BingoGameViewContorller
//            destinationController.UserQuestionArray = self.QuestionArray
            destinationController.UserQuestionSet = self.QuestionArray
        }
    }
    
  
}
