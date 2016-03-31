//
//  QuestionPageViewContorller.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

protocol Myprotocol {
    func PassDataBack(viewUrl:QuestionSet)
}



class QuestionPageViewContorller: UIViewController {

    var QuestionArray:QuestionSet = QuestionSet.init()
    var QuestionNumber = 0
    var myBoolVar = false
    var delegate : Myprotocol?
     
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
//      Do any additional setup after loading the view.
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
            QuestionArray.isAnswered[QuestionNumber] = true
            self.delegate?.PassDataBack(QuestionArray)
            if let navController = self.navigationController {
                navController.popViewControllerAnimated(true)
            }
        }
    }
    @IBAction func TextFieldDone(sender: AnyObject) {
        sender.resignFirstResponder()
    }
    @IBAction func backgroundtap(sender: AnyObject) {
        Answer_txt.resignFirstResponder()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toBingiGameView" {
            let destinationController =  segue.destinationViewController as! BingoGameViewContorller
            destinationController.UserQuestionSet = self.QuestionArray
        }
    }


  
}
