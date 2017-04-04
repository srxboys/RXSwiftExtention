//
//  RXSharkPlayerController.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/4.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

fileprivate let SharkPlayerCellId = "SPCI"

class RXSharkPlayerController: RXBaseViewController {

    
    fileprivate lazy var flowLayout = UICollectionViewFlowLayout()
    
    fileprivate lazy var collection : UICollectionView = {[weak self] in
        let collection = UICollectionView(frame: CGRect(), collectionViewLayout: (self?.flowLayout)!)
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
        view.addSubview(collection)
    }
    
    fileprivate func collecionViewAddView() {
        
    }
}

// MARK: --- 注册cell -----
extension RXSharkPlayerController {
    fileprivate func regisetCell() {
        collection.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: SharkPlayerCellId)
    }
}

// MARK: --- UICollectionViewDataSource -----
extension RXSharkPlayerController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //灰条
        let spaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: SharkPlayerCellId, for: indexPath)
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
