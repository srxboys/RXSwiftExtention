//
//  RXHomeImageScrollViewModel.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/31.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXHomeImageScrollViewModel: NSObject {

    func ImageScrollReques(_ finishCallback : @escaping() -> ()) {
        var paramts = [String:Any]()
        for key in PARAMSCOMMON.keys {
            paramts[key] = PARAMSCOMMON[key]
        }
        paramts["method"] = "b2c.advertising2.homefocus"
        paramts["sign"] = "2D3C0AC369994308EE069B959246B100"
        
        RXNetworkTools.postData(parameters: paramts) { (result:Any, status:Bool, message:String) in
            RXLog("接口状态 \(status)\n message= \(message)\n \(result)\n")
        }
      
    }
    
}
