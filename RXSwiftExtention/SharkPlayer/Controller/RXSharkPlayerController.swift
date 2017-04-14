//
//  RXSharkPlayerController.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/4.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

fileprivate let SharkPlayerGrayCellId = "SPGCI"

class RXSharkPlayerController: RXBaseViewController {
    
    fileprivate let ImageSH = RXActureHeight(180)

    fileprivate lazy var imageScrollView : RXImageScroller = {[weak self] in
        let imageScrollView = RXImageScroller(frame: CGRect(x: 0, y: 0, width: RXScreenWidth, height: self?.ImageSH ?? 0))
        return imageScrollView
    }()
    
    fileprivate lazy var flowLayout = UICollectionViewFlowLayout()
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let collection = UICollectionView(frame: CGRect(x: 0, y: RXNavHeight, width: RXScreenWidth, height: RXScreenHeight-RXNavHeight), collectionViewLayout: (self?.flowLayout)!)
        collection.backgroundColor = UIColor.white
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "视频专区"
        
        viewAddView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: --- ADD UI -----
extension RXSharkPlayerController {
    fileprivate func viewAddView() {
        view.addSubview(collectionView)
        collecionViewAddView()
    }
    
    fileprivate func collecionViewAddView() {
        regisetCell()
        collectionView.addSubview(imageScrollView)
        
    }
}

// MARK: --- 注册cell -----
extension RXSharkPlayerController {
    fileprivate func regisetCell() {
        collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: SharkPlayerGrayCellId)
    }
}

// MARK: --- UICollectionViewDataSource -----
extension RXSharkPlayerController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //灰条
        let spaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: SharkPlayerGrayCellId, for: indexPath)
        spaceCell.contentView.backgroundColor = UIColor.lightGray
        spaceCell.contentView.isUserInteractionEnabled = false
        return spaceCell
    }
}

// MARK: --- UICollectionViewDelegateFlowLayout -----
extension RXSharkPlayerController : UICollectionViewDelegateFlowLayout {
    //collection 上左下右
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    
    // itemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: RXScreenWidth, height: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
