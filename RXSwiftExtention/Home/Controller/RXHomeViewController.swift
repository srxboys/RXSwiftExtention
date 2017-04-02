//
//  RXHome.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

let HomeSpaceCellId = "HSCI"

class RXHomeViewController: RXBaseViewController {
    
    fileprivate let ImgScrollHeight = RXActureHeight(120)
    fileprivate lazy var imageScrollVM = RXHomeImageScrollViewModel()
    fileprivate lazy var homeLoadRequestVM =  RXHomeloadRequest()
    
    //初始化时赋值
    fileprivate lazy var collectionView : UICollectionView = {[unowned self]  in
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.backgroundColor = self.view.backgroundColor
        collectionView.contentInset = UIEdgeInsetsMake(self.ImgScrollHeight, 0, 0, 0)
        return collectionView;
    }()
    
    fileprivate lazy var imageScrollView : RXImageScroller = { [unowned self] in
        let imageScrollView = RXImageScroller(frame:CGRect(x: 0, y: -self.ImgScrollHeight, width: RXScreenWidth, height: self.ImgScrollHeight))
        imageScrollView.backgroundColor = UIColor.gray
        return imageScrollView
    }()
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        configUI();
    }
}

// MARK: --configUI--
extension RXHomeViewController{
   fileprivate func configUI()  {
        registCell()
        collectionView.addSubview(imageScrollView)
        view.addSubview(collectionView)
    
        reloadData()
    
    }
}

// MARK: --- 给Collection注册cell -----
extension RXHomeViewController {
    fileprivate func registCell() {
        //
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: HomeSpaceCellId)
        //git 横幅 cell
        collectionView.register(RXHomeGifAdCell.classForCoder(), forCellWithReuseIdentifier: HomeGifAdCellId)
        //icon cell
        collectionView.register(RXHomeMarketingCell.classForCoder(), forCellWithReuseIdentifier: HomeMarketingCellId)
        //icon 秒杀、买手、玩家
        collectionView.register(RXHomeBuyerPlayerCell.classForCoder(), forCellWithReuseIdentifier: HomeBuyerPlayerCellId)
    }
}

// MARK: --collectionView dataSource--
extension RXHomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0) {
            return 0
        }
        else if(section == 1) {
            if (homeLoadRequestVM.homeIconCheckImgDicM.count>4) {
                return 4
            }
            else {
                return 0
            }
        }
        else if(section == 1) {
            return 1
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let row = indexPath.item
        
        if(section == 0) {
//            横条gif广告
            let cell : RXHomeGifAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGifAdCellId, for: indexPath) as! RXHomeGifAdCell
            cell.contentView.backgroundColor = UIColor.randomColor()
            return cell
        }
        else if(section == 1) {
            //4个图标
            let cell : RXHomeMarketingCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMarketingCellId, for: indexPath) as! RXHomeMarketingCell
        
            let key = cell.getCellModelKey(row)
            let dict = homeLoadRequestVM.homeIconCheckImgDicM
            let valueObject = dictForKey(dict, key: key)
            var value = RXHomeIconModel()
            if(valueObject.isValue) {
                value = valueObject.object as! RXHomeIconModel
            }
            cell.setData(value)
//            cell.contentView.backgroundColor = UIColor.randomColor()
            return cell
        }
        else if(section == 1) {
            let cell : RXHomeGifAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGifAdCellId, for: indexPath) as! RXHomeGifAdCell
            cell.contentView.backgroundColor = UIColor.randomColor()
            return cell
        }
        
        let spaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSpaceCellId, for: indexPath)
        return spaceCell
    }
    
}

// MARK: --collectionView delegate--
extension RXHomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        if(section == 0) {
        //横条gif广告
        }
        else if(section == 1) {
            return CGSize(width: RXScreenWidth/4, height: RXScreenWidth/4-5-8)
       }
        else if(section == 2) {
           //横条gif广告
            return CGSize()
        }
        return CGSize()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RXLog("您 选择了 第几个item \(indexPath.item)")
    }

}

extension RXHomeViewController {
   fileprivate func reloadData() {
        imageScrollVM.ImageScrollReques {
            //轮播图
            self.imageScrollView.cycleModels = self.imageScrollVM.imageSAM
        }
    
        homeLoadRequestVM.homeRequetIcon {
            //icon
            self.collectionView.reloadSections(IndexSet(integer: 1))
        }
    
        homeLoadRequestVM.homeRequetBuyerPlayer { 
            //买手、玩家、秒杀
        }

    }
}

// MARK: --- 处理事件 -----
extension RXHomeViewController {
   
}

