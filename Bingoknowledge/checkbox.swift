//
//  checkbox.swift
//  Bingo_ver1
//
//  Created by killerhi2001 on 2016/3/19.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import UIKit

class checkbox: UIButton {
    
    //images
    let checkedImage = UIImage(named: "check_teacher")
    let unCheckedImage = UIImage(named: "uncheck_teacher")
    
    //bool propety
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }else{
                self.setImage(unCheckedImage, forState: .Normal)
            }
        }
    }
    
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    
    
    func buttonClicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true{
                isChecked = false
            }else{
                isChecked = true
            }
        }
    }
}
