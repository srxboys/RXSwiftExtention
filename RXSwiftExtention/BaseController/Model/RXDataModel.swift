//
//  RXDataModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
/*
 * 数据模型 基类
 */

import UIKit

class RXModel: NSObject {
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //不存在的
    }
    
    //便利构造函数(一般写在extension)
    convenience init(dict:[String:Any]) {
        self.init()
        setValuesForKeys(dict)
    }

}
