//
//  QuestionPageViewContorller.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/25.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class QuestionPageViewContorller: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var Question_Label: UILabel!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var Tipfield: UILabel!
    @IBOutlet weak var Questionfield: UILabel!
    @IBOutlet weak var Answer_txt: UITextView!
    @IBOutlet weak var Answer_Label: UILabel!
    @IBOutlet weak var Tip_Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SubmitBtn_clicked(sender: AnyObject) {
    }
    @IBAction func backBtn_clicked(sender: AnyObject) {
        self.performSegueWithIdentifier("returnBingoGameView", sender: self)
        let ctrl = storyboard?.instantiateViewControllerWithIdentifier("BingoGameView")  as! BingoGameViewContorller
        self.presentViewController(ctrl, animated: true, completion: nil)
    }
  
}
