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

class RXHomeIndexTVCell: UICollectionViewCell {
    fileprivate lazy var titleLabel:UILabel = {[weak self] in
        let titleLabel = UILabel()
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
