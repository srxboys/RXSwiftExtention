//
//  RXHomeBuyerPlayerCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/2.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit
let HomeBuyerPlayerCellId = "HBPCI"

protocol RXHomeBuyerPlayerCellDelegate : class {
    func homeBuyerPlayerTimeOut()
}

class RXHomeBuyerPlayerCell: UICollectionViewCell {
    weak var delegate : RXHomeBuyerPlayerCellDelegate?
    
//    fileprivate lazy var skilView = CellSkillView() as!! CellSkillView
//    fileprivate lazy var buyerImg = UIImageView()
//    fileprivate lazy var playerImg = UIImageView()
}


class CellSkillView: UIView {
    
}
