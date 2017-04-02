//
//  RXHomeIcon.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/2.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//5个icon 显示4个，根据是否新用户
import UIKit

class RXHomeIconModel: RXModel {
    var title : String = ""
    var img : String = ""
    var key : String = ""
    override init() {
        super.init()
    }
    
    convenience init(dict:[String:Any]) {
        self.init()
        title = dictForKeyString(dict, key: "title")
        img = dictForKeyString(dict, key: "img")
    }
}
