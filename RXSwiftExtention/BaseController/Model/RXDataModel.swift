//
//  RXDataModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
/*
 * 数据模型 都在这里
 */

import UIKit

class RXHomeModel: NSObject {
    let title : String? = nil
    let name : String? = nil
    let type = 0
    let image : String? = nil;
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        //不存在的
    }
    
    //便利构造函数(一般写在extension)
    convenience init(dict:[String:Any]) {
        self.init()
        setValuesForKeys(dict)
    }

}
