
//
//  RXHomeMarketingCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//4个icon
import UIKit
import Kingfisher

let HomeMarketingCellId = "HMCI"

class RXHomeMarketingCell: UICollectionViewCell {
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: --- 给cell赋值 -----
extension RXHomeMarketingCell {
    func setData (_ iconModel:RXHomeIconModel) {
        let iconURL = URL(string: iconModel.img ?? "")
        iconImg.kf.setImage(with: iconURL)
        nameLabel.text = iconModel.title
    }
}

// MARK: --- 获取cell 数据源 的 key -----
extension RXHomeMarketingCell {
    func getCellModelKey(_ row:Int) -> String {
        var  key = ""
        switch row {
        case 0:
            key = "checkin_img"
        case 1:
            key = "hotsales_img"
        case 2:
            key = "topics_img"
        case 3:
            key = "newexclusive_img"
        default:
            key = "checkin_img"
        }
        return key
    }
}
