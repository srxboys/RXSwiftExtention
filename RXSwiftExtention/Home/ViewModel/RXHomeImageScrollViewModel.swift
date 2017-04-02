//
//  RXHomeImageScrollViewModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/31.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXHomeImageScrollViewModel: NSObject {
    
    lazy var imageSAM = [RXImageScrollModel]()

    func ImageScrollReques(_ finishCallback : @escaping() -> ()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = "b2c.advertising2.homefocus"
        paramts["sign"] = "2D3C0AC369994308EE069B959246B100"
        
        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in

            if(status == false)  {
                RXLog(message)
                //show toash
                return
            }
            var arr = [Any]()
            if result is Array<Any>  {
                arr = result as! [Any]
            }
            let num = 1
            self.imageSAM.removeAll()
            for dict in arr {
                if dict is [String:Any] {
                    let model = RXImageScrollModel(dict: dict as! [String : Any])
                    model.tag = num
                    self.imageSAM.append(model)
                }
                else {
                    continue
                }
            }
            
            finishCallback()
        }
      
    }
    
}

class RXHomeloadRequest: NSObject {
    
    var homeIconISNew : Bool = false
    var homeIconBgImage : String?
    var homeIconCheckImgDicM = [String:RXHomeIconModel]()
    
    //MARK: - 显示4个，实际很多个icon(根据app版本选用)
    func homeRequetIcon(_ finishCallBack : @escaping()->()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = "b2c.advertising2.get_fourad"
        paramts["sign"] = "794D1E6C60811C484690049423C2C2BA"
        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in
            
            if(status == false)  {
                RXLog(message)
                //show toash
                return
            }
            var dataDict = [String:Any]()
            if result is [String:Any]  {
                dataDict = result as! [String:Any]
            }
            
            self.homeIconCheckImgDicM.removeAll()
            if dataDict is [String:Any] {
                for key in dataDict.keys {
                    var iconModel = RXHomeIconModel()
                    iconModel.key = key
                    let valueObject = dictForKeyDict(dataDict, key: key)
                    if(valueObject.isValue) {
                        let value = valueObject.object
                        if(value is [String:Any]) {
                            iconModel = RXHomeIconModel(dict: value)
                        }
                    }
                self.homeIconCheckImgDicM[key] = iconModel
            }
            }
            finishCallBack()
        }
        
    }
    
    //MARK: - 买手、玩家、秒杀
    var homeBuyerPlayerArrM = [String]()
    
    func homeRequetBuyerPlayer(_ finishCallBack : @escaping()->()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = "b2c.advertising2.buyrecomment"
        paramts["sign"] = "83B02F6B457F60DFB922E853D45EB297"
        
        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in
            //            RXLog("接口状态 \(status)\n message= \(message)\n returnData=\(result)\n")
            if(status == false)  {
                RXLog(message)
                //show toash
                return
            }
            var arr = [Any]()
            if result is Array<Any>  {
                arr = result as! [Any]
            }
            
            self.homeBuyerPlayerArrM.removeAll()
            for image in arr {
                if image is String {
                    if((image as! String).characters.count > 0) {
                        self.homeBuyerPlayerArrM.append(image as! String)
                    }
                }
                else {
                    continue
                }
            }
            
            finishCallBack()
        }

    }
}




