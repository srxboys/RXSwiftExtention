//
//  RXImageScrollModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXImageScrollModel: RXModel {
    var title : String = ""
    var type  : Int = 0
    var image : String = ""
    var link  : String = ""
    var wap_image : String = ""
    var is_login : Bool = false
    var image_width : CGFloat = 0
    var image_height : CGFloat = 0
    var tag : Int = 0
    
    var height : CGFloat {
        //计算属性
        return RXScreenWidth/2*image_height/image_width;
    }
    
    override init() {
        super.init()
    }
    
    convenience init(dict:[String:Any]) {
        self.init()
        //接口字段为什么要一个一个的取，因为类型总是换，特别是后台更换人
        title = dictForKeyString(dict, key: "title")
        type = dictForKeyInt(dict, key: "type")
        image = dictForKeyString(dict, key: "image")
        link = dictForKeyString(dict, key: "link")
        wap_image = dictForKeyString(dict, key: "wap_image")
        is_login = dictForKeyBool(dict, key: "is_login")
        image_width = dictForKeyCGFloat(dict, key: "image_width")
        image_height = dictForKeyCGFloat(dict, key: "image_height")
    }
}
