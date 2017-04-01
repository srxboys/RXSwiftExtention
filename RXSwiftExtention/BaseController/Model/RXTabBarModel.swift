
//
//  RXTabBarModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXTabBarModel: RXModel {
    var title : String = ""
    var type  : Int = 1
    var link  : String = ""
    var image_nomal : String = ""
    var image_selected : String = ""
    var starttime : String = ""
    var color_nomal : String = ""
    var color_selected : String = ""
    var is_login  : Bool = false
    
    //自用
    var activity : Bool = false
    var tagTabBar : Int = 0
    var noamlImgData : NSData?
    var selectedImgData : NSData?
}
