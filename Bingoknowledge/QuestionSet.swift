//
//  QuestionSet.swift
//  Bingo_ver1
//
//  Created by killerhi2001 on 2016/3/22.
//  Copyright © 2016年 killerhi2001. All rights reserved.
//

import Foundation

struct QuestionSet {
    var id:Int
    var Question :String
    var Answer :String
    var Tip :String
    var level:Int
    var isAnswered:Bool
    
    init(){
        id = 0
        Question = ""
        Answer = ""
        Tip = ""
        level = 0
        isAnswered = false
    }
    
    //print data
    func Print_Data(){
        print("id:\(self.id)\n Question:\(self.Question)\n Tips:\(self.Tip)\n Answer:\(self.Answer)\n isAnswerd?\(self.isAnswered)\n")
    }
}