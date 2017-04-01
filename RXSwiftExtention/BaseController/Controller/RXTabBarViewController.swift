//
//  ViewController.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

class RXTabBarViewController: UITabBarController {

    fileprivate lazy var _TabBarView : RXTabBarView = {[unowned self] in
        let tabBarView : RXTabBarView  = RXTabBarView(frame: self.tabBar.bounds)
        tabBarView.delegate = self
        tabBarView.backgroundColor = UIColor.white
        return tabBarView
    }()
    
    fileprivate var vcsName : [String] = ["首页","逛", "购物车","我的"]
    fileprivate let vcsIsa = [RXHomeViewController(), RXStrollViewController(), RXShopCartViewController(), RXProfileViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBar.bringSubview(toFront: _TabBarView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 初始化控件
extension RXTabBarViewController {
    fileprivate func configUI() {
        UITabBar.appearance().tintColor = UIColor.clear
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        
        tabBar.addSubview(_TabBarView)
        
        var vcArray : [UIViewController] = [UIViewController]()
        
        for i in 0..<vcsIsa.count {
            let nav = addChildViewController(vcsIsa[i], title: vcsName[i])
            vcArray.append(nav)
        }
        
        guard  (vcArray.count > 0) else {
            RXLog("没有页面")
            return
        }
        viewControllers = vcArray
    }
    
    fileprivate func addChildViewController(_ childController: UIViewController, title : String) -> RXBaseNavViewController {
        childController.title = title
        let navVC = RXBaseNavViewController()
        navVC.title = title
        navVC.addChildViewController(childController)
        return navVC
    }
    
}

// MARK: --- 实现tabBarView代理 ---
extension RXTabBarViewController : RXTabBarViewDelegate {
    func TabBarViewClick(_ TabBarItem: RXTabBarItem) {
        selectedIndex = TabBarItem.index;
    }
}


