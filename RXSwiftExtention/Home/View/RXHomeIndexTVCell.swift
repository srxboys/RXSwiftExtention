//
//  RXHomeIndexTVCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/3.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//TV抢购_banner

import UIKit
import Kingfisher

let HomeIndexTVCellId = "HITVCI"
let HomeIndexTVCellCellId = "HITVCCI"

fileprivate let controlHeight : CGFloat = 40.0

class RXHomeIndexTVCell: UICollectionViewCell {
    /// 左边Label
    fileprivate lazy var titleLabel:UILabel = {[weak self] in
        let width = self?.bounds.size.width
        let frame = CGRect(x: 8, y: 0, width: width! - 20 , height: controlHeight)
        let titleLabel = UILabel(frame: frame)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.RGB(r: 51, g: 51, b: 51)
        titleLabel.text = "TV抢购"
        titleLabel.textAlignment = .left
        titleLabel.isUserInteractionEnabled = false
        return titleLabel
    }()
    
    /// 右边Label
    fileprivate lazy var lookMoreLabel:UILabel = {[weak self] in
        let width = self?.bounds.size.width
        let frame = CGRect(x: 8, y: 0, width: width! - 20 - 8, height: controlHeight)
        let lookMoreLabel = UILabel(frame: frame)
        lookMoreLabel.font = UIFont.systemFont(ofSize: 12)
        lookMoreLabel.textColor = UIColor.RGB(r: 51, g: 51, b: 51)
        lookMoreLabel.text = "更多直播"
        lookMoreLabel.textAlignment = .right
        lookMoreLabel.isUserInteractionEnabled = false
        return lookMoreLabel
    }()
    
    /// 右边👉>
    fileprivate lazy var lookMoreImage : UIImageView = { [weak self] in
        let width = self?.bounds.size.width
        let w : CGFloat = 8
        let h : CGFloat = 14
        let y : CGFloat = (controlHeight - h)/2
        let frame = CGRect(x: width! - (w * 2), y: y, width: w, height: h)
        let lookMoreImage = UIImageView(frame: frame)
        lookMoreImage.image = UIImage(named: "home_arrow")
        return lookMoreImage
    }()
    
    /// 对于更多区域点击的
    fileprivate lazy var topControl: UIControl = { [weak self] in
        let width = self?.bounds.size.width
        let topControl = UIControl(frame: CGRect(x: 0, y: 0, width: width!, height: controlHeight))
        topControl.addTarget(self, action:#selector(HomeIndexTVClick), for: UIControlEvents.touchUpInside)
        return topControl
    }()
    
    
    /// 数据源 当值有变化，就刷新给页面
    fileprivate var indexTVArray =  [RXIndexTVModel]() {
        didSet {
            reloadCell()
        }
    }
    
    fileprivate lazy var collectionView:UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        let width = self?.bounds.size.width
        let height = self?.bounds.size.height
        let frame = CGRect(x: 0, y: controlHeight, width: width!, height: height! > 0 ? height! - controlHeight : 0)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:  --- 布局/注册cell ---
extension RXHomeIndexTVCell {
    fileprivate func addSubViews() {
        topControl.addSubview(titleLabel)
        topControl.addSubview(lookMoreLabel)
        topControl.addSubview(lookMoreImage)
        
        addSubview(topControl)
        addSubview(collectionView)
    }
    fileprivate func registerCell() {
        collectionView.register(RXHomeIndexTVCellCell.classForCoder(), forCellWithReuseIdentifier: HomeIndexTVCellCellId)
    }
    fileprivate func reloadCell() {
        collectionView.reloadData()
    }
}

// MARK:  --- Collection dataSource ---
extension RXHomeIndexTVCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indexTVArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RXHomeIndexTVCellCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIndexTVCellCellId, for: indexPath) as! RXHomeIndexTVCellCell
        cell.setCellModel(indexTVArray[indexPath.item])
        return cell
    }
}

// MARK:  --- Collection delegate ---
extension RXHomeIndexTVCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension RXHomeIndexTVCell {
   @objc fileprivate func HomeIndexTVClick() {
        
    }
}

// MARK:  --- CollectionCell ---
class RXHomeIndexTVCellCell: UICollectionViewCell {
    /// 商品名、价格 字体大小适配
    fileprivate let namePriceFont : UIFont = {
        var font = UIFont()
        font = UIFont.systemFont(ofSize: 16)// >= iphone6Plus的屏幕适配(7 8 9 10这个都要考虑)
        if(iPhone4 || iPhone5 || iPhone6) {
            font = UIFont.systemFont(ofSize: 14)
        }
        return font
    }()
    
    /// 价格
    fileprivate var priceSpaceHeight : CGFloat {
        get {
            var spaceH : CGFloat = 8 //iphone6
            if iPhone4 || iPhone5 {
                spaceH = 5
            }
            else if(iPhone6) {
                spaceH = 8
            }
            else { //iphone6Plus/iphone7Plus -> 8.9.10...
                spaceH = 16
            }
            return spaceH
        }
    }
    
    /// 商品图
    fileprivate lazy var goodImageView : UIImageView = {[weak self] in
        let goodImageView = UIImageView(frame: (self?.bounds)!)
        return goodImageView
    }()
    /// 直播中、已播出、xx播出
    fileprivate lazy var goodStatusLabel : UILabel = { [weak self] in
        let width = self?.bounds.size.width;
        let wh : CGFloat = 39
        let goodStatusLabel = UILabel(frame: CGRect(x: width! - wh, y: 0, width: wh, height: wh))
        goodStatusLabel.font = UIFont.systemFont(ofSize: 10)
        return goodStatusLabel
    }()
    /// 商品名
    fileprivate lazy var goodNameLabel : UILabel = { [weak self] in
        let goodNameLabel = UILabel()
        goodNameLabel.textColor = UIColor.RGB(r: 51, g: 51, b: 51)
        goodNameLabel.numberOfLines = 2
        goodNameLabel.textAlignment = .center
        goodNameLabel.font = self?.namePriceFont
        return goodNameLabel
    }()
    
    /// 商品价格
    fileprivate lazy var goodPriceLabel : UILabel = {[weak self] in
        let goodPriceLabel = UILabel()
        goodPriceLabel.font = self?.namePriceFont
        goodPriceLabel.textColor = UIColor.RGB(r: 127, g: 16, b: 32)
        return goodPriceLabel
    }()
    
    /// 商品优惠标签
    fileprivate lazy var goodFlagLabel : UILabel = {[weak self] in
        let goodFlagLabel = UILabel()
        goodFlagLabel.font = UIFont.systemFont(ofSize: 12)
        goodFlagLabel.textAlignment = .center
        goodFlagLabel.textColor = UIColor.RGB(r: 127, g: 16, b: 32)
        return goodFlagLabel
        }()
}

extension RXHomeIndexTVCellCell {
    fileprivate func setCellModel(_ model:RXIndexTVModel) {
        goodNameLabel.textAlignment = .center
    }
}


