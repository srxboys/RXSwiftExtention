
//
//  RXHomeMarketingCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//4个icon_banner
import UIKit
import Kingfisher

let HomeMarketingCellId = "HMCI"


enum homeMarkType : String {
    case homeMarkType_checkin_img = "checkin_img" //签到
    case homeMarkType_hotsales_img = "hotsales_img" //热销
    case homeMarkType_topics_img = "topics_img" //专题
    case homeMarkType_newexclusive_img = "newexclusive_img" //新人专享
    case homeMarkType_discount_img = "discount_img" //会员折扣店
    case homeMarkType_market_img = "market_img" //超时
    case homeMarkType_global_shopping_img = "global_shopping_img" //全球购
}


protocol RXHomeMarketingCellDelegate:class {
    func homeMarketionCellClick(_ rowKey:String, row :Int)
}

class RXHomeMarketingCell: UICollectionViewCell {
    
    fileprivate var currentRow = 0
    weak var delegate : RXHomeMarketingCellDelegate?
    
    fileprivate lazy var iconImg : UIImageView = { [unowned self] in
        let X : CGFloat = 27
        let Y : CGFloat = 10
        let WH : CGFloat = self.bounds.size.width - (X * 2)
        let iconImg = UIImageView(frame: CGRect(x: X, y: Y, width: WH, height: WH))
        return iconImg
    }()
    
    fileprivate lazy var nameLabel : UILabel = { [unowned self] in
        let width : CGFloat = self.bounds.size.width
        let Y : CGFloat = (width - 54) + 10 + 7
        let height : CGFloat = 14
        let nameLabel = UILabel(frame: CGRect(x: 0, y: Y, width: width, height: height))
        nameLabel.textColor = UIColor.RGB(r: 102, g: 102, b: 102)
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconImg)
        contentView.addSubview(nameLabel)
        
        addTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: --- 给cell赋值 -----
extension RXHomeMarketingCell {
    func setData (_ iconModel:RXHomeIconModel, row : Int) {
        currentRow = row
        let iconURL = URL(string: iconModel.img)
        iconImg.kf.setImage(with: iconURL)
        nameLabel.text = iconModel.title
    }
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(marketingCellClick))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        contentView.addGestureRecognizer(tap)
    }
}

// MARK: --- 获取cell 数据源 的 key -----
extension RXHomeMarketingCell {
    func getCellModelKey(_ row:Int) -> String {
        var  key = ""
        switch row {
        case 0:
            key = homeMarkType.homeMarkType_checkin_img.rawValue
        case 1:
            key = homeMarkType.homeMarkType_hotsales_img.rawValue
        case 2:
            key = homeMarkType.homeMarkType_topics_img.rawValue
        case 3:
            key = homeMarkType.homeMarkType_newexclusive_img.rawValue
        default:
            key = homeMarkType.homeMarkType_checkin_img.rawValue
        }
        return key
    }
}

// MARK: --- 事件监听 -----
extension RXHomeMarketingCell {
    @objc func marketingCellClick() {
        delegate?.homeMarketionCellClick(getCellModelKey(currentRow), row: currentRow)
    }
}
