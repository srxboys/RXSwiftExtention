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
public func RXLog<ANY>(_ log : ANY,filePath:String = #file, line:Int = #line, funcName:String = #function)  {
    SrxboysLog(log, isError: false,filePath:filePath,line:line, funcName:funcName)
}

public func RXErrorLog<ANY>(_ log : ANY,filePath:String = #file, line:Int = #line, funcName:String = #function)  {
    SrxboysLog(log, isError: true, filePath:filePath, line:line, funcName:funcName)
}

private func SrxboysLog<ANY>(_ log : ANY, isError:Bool, filePath:String = #file, line:Int = #line, funcName:String = #function)  {
    
#if DEBUG
    
    print()
    if(isError) {
        print("❌❌❌❌❌❌❌")
    }
    else {
        print("👇👇👇👇👇👇👇")
    }
    //文件所在路径
    guard let file = filePath.components(separatedBy: "/").last else {
        print("文件不存在")
        return;
    }
    print("   Ⓕⓘⓛⓔ ⏩ " + file)
    
    //行数
    print("   Ⓛⓘⓝⓔ ⏩ \(line)")
    
    //方法
    print("   Ⓕⓤⓝⓒⓣⓘⓞⓝ ⏩ " + funcName)
    print()
    print(log);
    print()
    if(isError) {
        print("🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺")
    }
    else {
        print("👉👉👉👉👉👉👉👉👉👉👉👉👉👉")
    }
    print()
#endif
}

//MARK: - 获取分辨率
public let RXNavHeight : CGFloat = 64
public let RXTabBarHeight : CGFloat = 49
public let RXScreenWidth = UIScreen.main.bounds.width
public let RXScreenHeight = UIScreen.main.bounds.height

//MARK: - 宽高比定义  roundf 四舍五入函数
public func RXActureHeight(_ height:CGFloat) -> CGFloat {
    return height/375 * RXScreenWidth
}

public func RXActureHeightV(_ height:CGFloat) -> CGFloat {
    return height/667.0 * RXScreenHeight
}




//这个还是不行
//public let SELF_CLASS_NAME = (#file as String).components(separatedBy: "/").last?.replacingOccurrences(of: ".swift", with: "")

