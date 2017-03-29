//
//  RXTabBarView.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
import UIKit

class RXTabBarView: UIView {
    fileprivate lazy var _tabBarItem1 : RXTabBarItem = {[weak self] in
        let Item = RXTabBarItem(name: "推荐", index: 0)
        Item.delegate = self
        return Item
    }()
    
    fileprivate lazy var _tabBarItem2  : RXTabBarItem = {[weak self] in
    let tabBarItem = RXTabBarItem(name: "逛", index: 1)
    tabBarItem.delegate = self
    return tabBarItem
    }()
    
    fileprivate lazy var _tabBarItem3 : RXTabBarItem = {[weak self] in
        let tabBarItem = RXTabBarItem(name: "购物车", index: 2)
        tabBarItem.delegate = self
        return tabBarItem
        }()
    
    fileprivate lazy var _tabBarItem4: RXTabBarItem = {[weak self] in
        let tabBarItem = RXTabBarItem(name: "我的", index: 3)
        tabBarItem.delegate = self
        return tabBarItem
        }()
    
    fileprivate lazy var _tabBarItem5 : RXTabBarItem = {[weak self] in
        let tabBarItem = RXTabBarItem(name: "", index: 4)
        tabBarItem.delegate = self
        return tabBarItem
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RXTabBarView : RXTabBarItemDelegate {
    fileprivate func configUI() {
        addSubview(_tabBarItem1)
        addSubview(_tabBarItem2)
        addSubview(_tabBarItem3)
        addSubview(_tabBarItem4)
        addSubview(_tabBarItem5)
    }
    
    func TabBarItem(_ TabBarItem: RXTabBarItem) {
        RXLog("点击了 tabbar是 \(TabBarItem.index)")
    }
}
