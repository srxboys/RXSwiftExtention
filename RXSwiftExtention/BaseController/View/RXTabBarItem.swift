//
//  RXTabBarItem.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol RXTabBarItemDelegate : class {
    func TabBarItem(_ TabBarItem : RXTabBarItem)
}


class RXTabBarItem: UIView {
    
    var index : Int
    
    weak var delegate : RXTabBarItemDelegate?
    
    fileprivate lazy var _imageView = UIImageView()
    fileprivate lazy var _nameLabel  = UILabel()
    fileprivate var _nameString : String?
    fileprivate lazy var _lineView : UIView = {
        var lineView = UIView()
        lineView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 0.5)
        lineView.backgroundColor = UIColor(r: 170, g: 170, b: 170)
        return lineView
    }()
    
    init(name: String, index : Int) {
        _nameString = name
        self.index = index
        var w : CGFloat = ScreenWidth/4
        var x : CGFloat = CGFloat(index) * w
        if(index == 4) {
            x = 0
            w = 0
        }
        let frame  = CGRect(x: x, y: 0, width: w, height: TabBarHeight)
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension RXTabBarItem {    
    ///初始化界面
    fileprivate func configUI() {
        addSubview(_lineView)
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        let imgW : CGFloat = 24
        let imgH : CGFloat = 22.5
        let imgX : CGFloat = (width - imgW)/2.0
        let imgY : CGFloat = 8.0
        
        var isFirst : Bool = true
        if(index == 0) {
            isFirst = false
        }
        
        var imgFrame : CGRect = CGRect(x:imgX, y:imgY, width:imgW, height:imgH)
        
        if(index == 4) {
            imgFrame = CGRect()
        }
        
        _imageView.image = UIImage(named:getTabBarName(index, isNomal: isFirst))
        _imageView.frame = imgFrame
        addSubview(_imageView)
        
        let labelY : CGFloat = imgY + imgH + 5
        let labelH : CGFloat = height - labelY
        
        var labelFrame : CGRect = CGRect(x: 0, y: labelY, width: width, height: labelH)
        
        if(index == 4) {
            labelFrame = CGRect()
        }

        _nameLabel.textColor = UIColor.darkGray
        _nameLabel.frame = labelFrame
        _nameLabel.textAlignment = .center
        _nameLabel.font = UIFont(name: "Helvetica", size: 10)
        addSubview(_nameLabel)
        
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.viewClick))
        addGestureRecognizer(tapGes)
        
        
        guard (_nameString != nil)  else {
            RXLog("名字为nil")
            return
        }
        
        guard ((_nameString?.characters.count)! > 0) else {
            RXLog("名字长度 不行 index=\(index)")
            return
        }
        
        _nameLabel.text = _nameString!
        RXLog("_nameLabel \(_nameString!) .frame=  \(_nameLabel.frame)")
    }
    
    
    func getTabBarName(_ index : Int , isNomal : Bool ) -> String {
        
        if(index > 3) {
            return ""
        }
        
        if(isNomal) {
            return "tab_\(index)"
        }
        else {
            return "tab_\(index)_h"
        }
    }
    
    @objc fileprivate func viewClick() {
        delegate?.TabBarItem(self)
    }
}


extension RXTabBarItem {
    
}
