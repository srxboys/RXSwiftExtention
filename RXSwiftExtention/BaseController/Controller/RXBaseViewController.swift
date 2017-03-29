//
//  RXBaseViewController.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        configBaseViewUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //OC的 dealloc
        RXLog("loc")
    }
}

extension RXBaseViewController {
    fileprivate func configBaseViewUI() {
        view.backgroundColor = UIColor.white
    }
}
