//
//  RXNetworkTools.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class RXNetworkTools {
    
    class func postData(parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any, _ status:Bool, _ message:String) -> ()) {
        guard (parameters?.keys.count)! > 0 else {
            assert(false, "参数有误")
            return;
        }
        printHttp(parameters!)
        requestHttpData(.post, URLString: SERVER, parameters: parameters) { (result : Any) in
            
            guard result != nil else {
                finishedCallback("", false, "服务器错误")
                return
            }
            
            // 1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else {
                finishedCallback("", false, "服务器错误")
                return
            }
            
            // 2.1根据data该key,获取服务器信息
            let dataDictModel = dictForKeyDict(resultDict, key: "data")
            
            var dataDict = [String:Any]()
            if(dataDictModel.isValue) {
                dataDict = dataDictModel.object
            }
            else {
                finishedCallback("", false, dictForKeyString(resultDict, key: "data"))
                return
            }
            
            //一般直接打印就好，我是为了学习
//            RXPrintJSON(printObject: dataDict)
            
            
            //3.1根据data该key,获取服务器是否使用 https
            let returnIsHttps = dictForKeyBool(dataDict, key: "is_https")
            RXLog("服务器的请求接口头采用是否采用https= \(returnIsHttps)")
            
            //3.2根据message,获取 接口信息
            let returnMessage = dictForKeyString(dataDict, key: "message")
            
            //3.3根据status,获取 接口信息的状态
            let returnStatus = dictForKeyBool(dataDict, key: "status")
            
            //3.4
            let returnDataModel = dictForKey(dataDict, key: "returndata")
            if(returnDataModel.isValue){
                finishedCallback(returnDataModel.object, returnStatus, "")
            }
            else {
                finishedCallback("", returnStatus, returnMessage)
            }

        }
    }

    fileprivate class func requestHttpData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
            guard let result = response.result.value else {
                RXLog(response.result.error)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}




