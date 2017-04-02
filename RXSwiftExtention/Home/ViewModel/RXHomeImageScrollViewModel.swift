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
