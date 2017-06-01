//
//  RXIndexTV.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/3.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXIndexTVModel: RXModel {
    var tv_id : String = ""
    var sku : String = ""
    var name : String = ""
    var goods_id : String = ""
    var price : Int = 0
    var marketprice : Int = 0
    var price_flag : String = ""
    var image : String = ""
    var starttime : Int = 0
    var endtime : Int = 0
    var currenttime : Int = 0
    //为什么不写 set get  一般set get 不是本身(why:自己循环了)
    //只重写了get方法，没重写set方法，所以外界不能赋值，只能是只读属性
    //var _currenttime : Int{
//        get {
//            print(hashValue)
//            if(self.currenttime > 0) { return self.currenttime }
//            return Int(Date().timeIntervalSince1970)
//        }
//        
//        set {
//            if(newValue > 0) {
//                self.currenttime = newValue
//            }
//        }
//    }
    var channel_name : String = ""
    var live_stream_uris : String = ""
    var is_multiple : Int = 0
    var descriptionStr : String = ""
    
    var isLiveType : Int = 0
    
    override init() {
        super.init()
    }
    
    convenience init(dict:[String:Any]) {
        self.init()
        tv_id = dictForKeyString(dict, key: "tv_id")
        sku = dictForKeyString(dict, key: "sku")
        goods_id = dictForKeyString(dict, key: "goods_id")
        price = dictForKeyInt(dict, key: "price")
        marketprice = dictForKeyInt(dict, key: "marketprice")
        price_flag = dictForKeyString(dict, key: "price_flag")
        image = dictForKeyString(dict, key: "image")
        starttime = dictForKeyInt(dict, key: "starttime")
        endtime = dictForKeyInt(dict, key: "endtime")
        currenttime = dictForKeyInt(dict, key: "currenttime")
        channel_name = dictForKeyString(dict, key: "channel_name")
        live_stream_uris = dictForKeyString(dict, key: "live_stream_uris")
        is_multiple = dictForKeyInt(dict, key: "is_multiple")
        descriptionStr = dictForKeyString(dict, key: "description")
        
        //没有用重写get set
        if(currenttime <= 0) {
            currenttime = Int(Date().timeIntervalSince1970)
        }
        
        //也可以用计算属性
        if(endtime < currenttime) {
            isLiveType = 0;
        }
        else if(starttime > currenttime) {
            isLiveType = 2;
        }
        else {
            isLiveType = 1;
        }
        
    }
}
