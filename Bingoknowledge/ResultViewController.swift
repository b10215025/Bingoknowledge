//
//  ResultViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/4/6.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var totalscore_label: UILabel!
    @IBOutlet weak var score_label: UILabel!
    @IBOutlet weak var result_background: UIImageView!
//    @IBOutlet weak var iconbackground: UITextView!
//    @IBOutlet weak var resulttxt: UITextView!
    @IBOutlet weak var returnGameMainView: UIButton!
    var score : Int = 0
    var totalscore:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        score_label.text = "\(score)"
        totalscore_label.text = "\(totalscore)"
          view.sendSubviewToBack(result_background)
        self.navigationItem.hidesBackButton = true

//        resulttxt.layer.cornerRadius = CGFloat(Float(15.0))
//        iconbackground.layer.cornerRadius = CGFloat(Float(15.0))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func returnGameMainViewBtn_clicked(sender: AnyObject) {

        
        if let navController = self.navigationController {
            navController.popToViewController(navController.viewControllers[1] as UIViewController, animated: true)

        }
    }
    


}
