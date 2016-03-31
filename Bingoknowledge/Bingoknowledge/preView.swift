//
//  preView.swift
//  Bingoknowledge
//
//  Created by killerhi2001 on 2016/3/29.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class preView: UIStoryboardSegue {
    override func perform() {
        let src: UIViewController = (self.sourceViewController)
        src.navigationController!.delegate = nil
        src.navigationController!.popViewControllerAnimated(true)
    }
}
