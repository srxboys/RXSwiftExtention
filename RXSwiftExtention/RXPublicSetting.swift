//
//  RXPushSetting.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXPublicSetting: NSObject {
    
    
}

//MARK: - 自定义日志格式
func RXLog<ANY>(log : ANY,filePath:String = #file, line:Int = #line, funcName:String = #function)  {
    print()
    print(">>>>>>>>>>>")
    //文件所在路径
    guard let file = filePath.components(separatedBy: "/").last else {
        print("文件不存在")
        return;
    }
    print("   FILE -> " + file)
    
    //行数
    print("   LINE -> \(line)")
    
    //方法
    print("   FUNCTION - >" + funcName)
    
    print(log);
    
    print("<<<<<<")
}
