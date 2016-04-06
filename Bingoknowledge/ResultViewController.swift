//
//  ResultViewController.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/4/6.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var returnGameMainView: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func returnGameMainViewBtn_clicked(sender: AnyObject) {
//        self.performSegueWithIdentifier("toGameMainView", sender: self)
        print(self.navigationController?.viewControllers.count)
        if let navController = self.navigationController {
            navController.popToViewController(navController.viewControllers[1] as UIViewController, animated: true)
//            navController.popToRootViewControllerAnimated(true)
        }
    }
    


}
