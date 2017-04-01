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
}
