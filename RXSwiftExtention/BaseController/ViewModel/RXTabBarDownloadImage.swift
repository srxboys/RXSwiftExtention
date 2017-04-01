//
//  RXTabBarDownloadImage.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/29.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

/*
 *  tabBar 网络下载 (后期维护)
 */


import UIKit

class RXTabBarDownloadImage: NSObject {
    fileprivate var queue : OperationQueue = {
       let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.waitUntilAllOperationsAreFinished()
        return queue
    }()
    
    //接口值
    fileprivate var dataArray = [[String:String]]()
    
    //下载后转换的模型 的数组
    fileprivate var downFinallArray : [RXTabBarModel] = [RXTabBarModel]()
    
}

// MARK: - 下载操作
extension RXTabBarDownloadImage {
    //开始下载
    fileprivate func recoveryDownload()  {
        downFinallArray = [RXTabBarModel]()
        var nomalOperation : BlockOperation?
        var operationsArray = [BlockOperation]()
        
        
        for i in 0..<dataArray.count {
            guard dataArray[i].isEmpty != false else {
                //并告诉下载者 下载失败
                return
            }
            
            let dict = dataArray[i] as [String: String]
            
            let tabBarModel =  RXTabBarModel()
            
            //这里我没有写string的key，下面是做个样式
            guard (tabBarModel.noamlImgData?.length)! > 0 || (tabBarModel.selectedImgData?.length)! > 0 else {
                //并告诉下载者 下载失败
                return
            }
            
            
            
        }
        
        
        let activtyOp = BlockOperation{() -> Void in
            //这里code
        }
    }
}

// MARK: - 外部调用
extension RXTabBarDownloadImage {
    func downloadTabBar(array : NSArray) {
        guard array.count > 0 else {
            return
        }
    }
    
    
}
