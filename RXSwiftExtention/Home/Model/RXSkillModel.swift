//
//  RXSkillModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/3.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXSkillModel: RXModel {
    
    var id : String = ""
    var title : String = ""
    var image : String = ""
    var startTime : String = ""
    var endTime : String = ""
    var now : String = ""
    var price : Float = 0
    var discount : NSString {
        return String(format: "%.02f", price) as NSString
    }
    
    override init() {
        super.init()
    }
    
    convenience init(dict:[String:Any]) {
        self.init()
        id = dictForKeyString(dict, key: "id")
        title = dictForKeyString(dict, key: "title")
        image = dictForKeyString(dict, key: "image")
        startTime = dictForKeyString(dict, key: "starttime")
        endTime = dictForKeyString(dict, key: "endtime")
        now = dictForKeyString(dict, key: "now")
        price = dictForKeyFloat(dict, key: "price")
    }
    
}
