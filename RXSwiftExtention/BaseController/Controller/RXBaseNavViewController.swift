//
//  RXBaseNavViewController.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 隐藏要push的控制器的tabbar
        viewController.hidesBottomBarWhenPushed = true
        
        //压栈
        let is_life : Bool = (navigationController?.viewControllers.contains(RXHomeViewController()))!
        RXLog("首页控制器 是否存在 \(is_life)")
        
        super.pushViewController(viewController, animated: animated)
    }

}











