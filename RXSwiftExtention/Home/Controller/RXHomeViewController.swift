//
//  RXHome.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit



class RXHomeViewController: RXBaseViewController {
    
    fileprivate let ImgScrollHeight = RXActureHeight(120)
    fileprivate lazy var imageScrollVM = RXHomeImageScrollViewModel()
    
    //初始化时赋值
    fileprivate lazy var collectionView : UICollectionView = {[unowned self]  in
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowlayout)
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.backgroundColor = self.view.backgroundColor
        collectionView.register(RXHomeMarketingCell.classForCoder(), forCellWithReuseIdentifier: HomeMarketingCellId)
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
        collectionView.addSubview(imageScrollView)
        view.addSubview(collectionView)
    
        reloadData()
    
    }
}


// MARK: --collectionView dataSource--
extension RXHomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let section = indexPath.section
//        if(section == 0) {
            //横条gif广告
//        }
//        else if(section == 1) {
            //4个图标
            let cell : RXHomeMarketingCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMarketingCellId, for: indexPath) as! RXHomeMarketingCell
            cell.setData()
            return cell
//        }
//        else {
//            
//        }
    }
    
}

// MARK: --collectionView delegate--
extension RXHomeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let section = indexPath.section
        //        if(section == 0) {
        //横条gif广告
        //        }
        //        else if(section == 1) {
        return CGSize(width: RXScreenWidth/4, height: RXScreenWidth/4-5-8)
        //       }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        RXLog("您 选择了 第几个item \(indexPath.row)")
    }

}

extension RXHomeViewController {
   fileprivate func reloadData() {
        imageScrollVM.ImageScrollReques {
            self.imageScrollView.cycleModels = self.imageScrollVM.imageSAM
        }
    }
}

// MARK: --- 处理事件 -----
extension RXHomeViewController {
   
}

