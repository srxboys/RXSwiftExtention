//
//  RXPushSetting.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
/*
 * 通用 文件都在这里
 */


import UIKit

//MARK: - 自定义日志格式
func RXLog<ANY>(_ log : ANY,filePath:String = #file, line:Int = #line, funcName:String = #function)  {
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

//MARK: - 获取分辨率
public let RXNavHeight : CGFloat = 64
public let RXTabBarHeight : CGFloat = 49
public let RXScreenWidth = UIScreen.main.bounds.width
public let RXScreenHeight = UIScreen.main.bounds.height

//MARK: - 宽高比定义  roundf 四舍五入函数
func RXActureHeight(_ height:CGFloat) -> CGFloat {
    return height/375 * RXScreenWidth
}

func RXActureHeightV(_ height:CGFloat) -> CGFloat {
    return height/667.0 * RXScreenHeight
}




//这个还是不行
//public let SELF_CLASS_NAME = (#file as String).components(separatedBy: "/").last?.replacingOccurrences(of: ".swift", with: "")

