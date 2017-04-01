
//
//  RXTabBarModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXTabBarModel: RXModel, NSCoding{
    var title : String? = ""           //标题
    var type  : Int = 1               //跳转类型
    var link  : String? = ""           //链接、id
    var image_nomal : String? = ""     //默认图片
    var image_selected : String? = ""  //选中图片
    var color_nomal : String? = ""     //默认字体颜色
    var color_selected : String? = ""  //选中字体颜色
    var is_login  : Bool = false      //是否需要登录(哪里点击，哪里处理)
    //这个是服务器的逻辑，可以不考虑
    var starttime : String? = ""
    var endtime : String? = ""
    
    //自用
    var activity : Bool = false       //是否为活动标题
    var tagTabBar : Int = 0           //tag
    var noamlImgData : NSData?        //默认图片data
    var selectedImgData : NSData?     //选中图片data

    convenience override init() {
        self.init()
    }
    
    convenience init(dict:[String:Any]) {
        self.init()
        //接口字段为什么要一个一个的取，因为类型总是换，特别是后台跟换人
        title = dictForKeyString(dict, key: "title")
        type = dictForKeyInt(dict, key: "type")
        link = dictForKeyString(dict, key: "link")
        image_nomal = dictForKeyString(dict, key: "image_nomal")
        image_selected = dictForKeyString(dict, key: "image_selected")
        color_nomal = dictForKeyString(dict, key: "color_nomal")
        color_selected = dictForKeyString(dict, key: "color_selected")
        is_login = dictForKeyBool(dict, key: "is_login")
        starttime = dictForKeyString(dict, key: "starttime")
        endtime = dictForKeyString(dict, key: "endtime")
       
    }
    
    //归档编码
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(link, forKey: "link")
        aCoder.encode(image_nomal, forKey: "image_nomal")
        aCoder.encode(image_selected, forKey: "image_selected")
        aCoder.encode(color_nomal, forKey: "color_nomal")
        aCoder.encode(color_selected, forKey: "color_selected")
        aCoder.encode(is_login, forKey: "is_login")
        aCoder.encode(starttime, forKey: "starttime")
        aCoder.encode(endtime, forKey: "endtime")
        aCoder.encode(activity, forKey: "activity")
        aCoder.encode(tagTabBar, forKey: "tagTabBar")
        aCoder.encode(noamlImgData, forKey: "noamlImgData")
        aCoder.encode(selectedImgData, forKey: "selectedImgData")
    }
    
    //解档
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as? String
        type = aDecoder.decodeInteger(forKey: "type")
        link = aDecoder.decodeObject(forKey: "link") as? String
        image_nomal = aDecoder.decodeObject(forKey: "image_nomal") as? String
        image_selected = aDecoder.decodeObject(forKey: "image_selected") as? String
        color_nomal = aDecoder.decodeObject(forKey: "color_nomal") as? String
        is_login = aDecoder.decodeBool(forKey: "is_login")
        starttime = aDecoder.decodeObject(forKey: "starttime") as? String
        endtime = aDecoder.decodeObject(forKey: "endtime") as? String
        activity = aDecoder.decodeBool(forKey: "activity")
        tagTabBar = aDecoder.decodeInteger(forKey: "tagTabBar")
        noamlImgData = aDecoder.decodeObject(forKey: "noamlImgData") as? NSData
        selectedImgData = aDecoder.decodeObject(forKey: "selectedImgData") as? NSData
    }
}
