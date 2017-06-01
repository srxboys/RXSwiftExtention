//
//  RXHomeImageScrollViewModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/31.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//所有请求数据都在这里

import UIKit

class RXHomeImageScrollViewModel: NSObject {
    lazy var imageSAM = [RXImageScrollModel]()
    func ImageScrollReques(_ finishCallback : @escaping() -> ()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = HOME_FOCUS_PATH
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
        paramts["method"] = HOME_FOUR_ICON_PATH
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
            for key in dataDict.keys {
                var iconModel = RXHomeIconModel()
                iconModel.key = key
                let valueObject = dictForKeyDict(dataDict, key: key)
                if(valueObject.isValue) {
                    let value = valueObject.object
                    iconModel = RXHomeIconModel(dict: value)
                }
                
                self.homeIconCheckImgDicM[key] = iconModel
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
        paramts["method"] = HOME_SKILLBP_PATH
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
    
    //MARK: - 秒杀
    var homeSkillModel = RXSkillModel()
    func homeRequetSkill(_ finishCallBack : @escaping ()->()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = HOME_SKILL_PATH
        paramts["sign"] = "5C45435C7200C1D9BDF41CCD8DAE29A9"
        
        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in
            if(status == false)  {
                RXLog(message)
                //show toash
                return
            }
            var returnDataDict = [String : Any]()
            if result is [String : Any]  {
                returnDataDict = result as! [String : Any]
            }
            self.homeSkillModel = RXSkillModel(dict: returnDataDict)
            
            finishCallBack()
        }
    }
    
    //MARK: - TV抢购
    var homeIndexTVArrM = [Any]()
    func homeRequetIndexTV(_ finishCallBack : @escaping ()->()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = HOME_INDEXTV_PATH
        paramts["sign"] = "98AE5C5F271A49BBD7FA2503BA6958FC"

        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in
            if(status == false)  {
                RXLog(message)
                //show toash
                return
            }
            var homeTVDict = [String:Any]()
            if result is [String:Any]  {
                homeTVDict = result as! [String:Any]
            }
            //需要定位信息 //我先写beijing吧
            let homeTVArrayObjc = dictForKey(homeTVDict, key: "beijing");
            if(!homeTVArrayObjc.isValue) {
                finishCallBack()
                return
            }
            let homeTVArray : [Any] = homeTVArrayObjc.object is [Any] ? homeTVArrayObjc.object as! [Any] : [Any]()
            for dict in homeTVArray {
                guard dict is [String : Any] else {
                    continue
                }
                let indexTVModel = RXIndexTVModel(dict: dict as! [String : Any])
                self.homeIndexTVArrM.append(indexTVModel)
            }
            
            finishCallBack()
        }
    }
}




