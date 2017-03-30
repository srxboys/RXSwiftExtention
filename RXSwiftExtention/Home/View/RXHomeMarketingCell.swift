
//
//  RXHomeMarketingCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

let HomeMarketingCellId = "HMCI"

class RXHomeMarketingCell: UICollectionViewCell {
    
    fileprivate lazy var iconImg : UIImageView = { [unowned self] in
        let XY : CGFloat = 27.0
        let WH : CGFloat = self.bounds.size.width - (XY * 2)
        let iconImg = UIImageView(frame: CGRect(x: XY, y: XY, width: WH, height: WH))
        return iconImg
    }()
    
    fileprivate lazy var nameLabel : UILabel = { [unowned self] in
        let width : CGFloat = self.bounds.size.width
        let height : CGFloat = width - 54 - 27
        let y : CGFloat = self.bounds.size.height - height
        let nameLabel = UILabel(frame: CGRect(x: 0, y: y, width: width, height: height))
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


extension RXHomeMarketingCell {
    func setData () {
        iconImg.backgroundColor = UIColor.gray
        nameLabel.text = "srxboys"
    }
}
