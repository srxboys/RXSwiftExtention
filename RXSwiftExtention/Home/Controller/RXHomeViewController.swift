//
//  RXHome.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/25.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

import UIKit

fileprivate let HomeSpaceCellId = "HSCI"

class RXHomeViewController: RXBaseViewController {
    
    fileprivate let ImgScrollHeight = RXActureHeight(150)
    fileprivate lazy var imageScrollVM = RXHomeImageScrollViewModel()
    fileprivate lazy var homeLoadRequestVM =  RXHomeloadRequest()
    
    //初始化时赋值
    fileprivate lazy var collectionView : UICollectionView = {[weak self]  in
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0
        flowlayout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: self?.view.bounds ?? CGRect(), collectionViewLayout: flowlayout)
        collectionView.delegate =  self
        collectionView.dataSource = self
        collectionView.backgroundColor = self?.view.backgroundColor ?? UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(self?.ImgScrollHeight ?? 0, 0, 0, 0)
        return collectionView;
    }()
    
    fileprivate lazy var imageScrollView : RXImageScroller = { [weak self] in
        let imageScrollView = RXImageScroller(frame:CGRect(x: 0, y: -(self?.ImgScrollHeight ?? 0), width: RXScreenWidth, height: self?.ImgScrollHeight ?? 0))
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
        // 秒杀、买手、玩家
        collectionView.register(RXHomeBuyerPlayerCell.classForCoder(), forCellWithReuseIdentifier: HomeBuyerPlayerCellId)
        // TV抢购
        collectionView.register(RXHomeIndexTVCell.classForCoder(), forCellWithReuseIdentifier: HomeIndexTVCellId)
    }
}

// MARK: --collectionView dataSource--
extension RXHomeViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(section == 0) {
            // gi 上 图
            return 0
        }
        else if(section == 1) {
            //显示4个icon
            return 4
//            不注释掉，cell会跳动
//            if (homeLoadRequestVM.homeIconCheckImgDicM.count>4) {
//                return 4 //4个横向显示
//            }
//            else {
//                
//            }
        }
        else if(section == 2) {
            //gif 下 图
            return 0
        }
        else if(section == 3) {
            //灰条
            return 1
        }
        else if(section == 4) {
            //秒杀、买手、玩家
            return 1
        }
        else if(section == 5) {
            //灰条
            return 1
        }
        else if(section == 6) {
            //TV抢购
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
//            横条gif广告 上
            let cell : RXHomeGifAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGifAdCellId, for: indexPath) as! RXHomeGifAdCell
            return cell
        }
        else if(section == 1) {
            //4个图标
            let cell : RXHomeMarketingCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMarketingCellId, for: indexPath) as! RXHomeMarketingCell
            cell.delegate = self
            let key = cell.getCellModelKey(row)
            let dict = homeLoadRequestVM.homeIconCheckImgDicM
            let valueObject = dictForKey(dict, key: key)
            var value = RXHomeIconModel()
            if(valueObject.isValue) {
                value = valueObject.object as! RXHomeIconModel
            }
            cell.setData(value, row: row)
            return cell
        }
        else if(section == 2) {
//            横条gif广告 下
            let cell : RXHomeGifAdCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeGifAdCellId, for: indexPath) as! RXHomeGifAdCell
            return cell
        }
        else if(section == 4) {
            //秒杀、买手、玩家
            let cell : RXHomeBuyerPlayerCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBuyerPlayerCellId, for: indexPath) as! RXHomeBuyerPlayerCell
            cell.delegate = self
            cell.setBuyerPlayerModel(bpArr: homeLoadRequestVM.homeBuyerPlayerArrM)
            cell.setSkillModel(model: homeLoadRequestVM.homeSkillModel)
            return cell
        }
        else if(section == 6) {
            // TV抢购
            let cell : RXHomeIndexTVCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeIndexTVCellId, for: indexPath) as! RXHomeIndexTVCell
            
            return cell
        }
        
        //灰条
        let spaceCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSpaceCellId, for: indexPath)
        spaceCell.contentView.backgroundColor = UIColor.lightGray
        spaceCell.contentView.isUserInteractionEnabled = false
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
            // 显示四个icon
            return CGSize(width: RXScreenWidth/4, height: RXScreenWidth/4-5-8)
       }
        else if(section == 2) {
           //横条gif广告
            return CGSize()
        }
        else if(section == 3) {
            //灰条
            return CGSize(width: RXScreenWidth, height: 10)
        }
        else if (section == 4) {
            //秒杀、买手、玩家
            return CGSize(width: RXScreenWidth, height: RXActureHeight(148))
        }
        else if(section == 5) {
            //灰条
            return CGSize(width: RXScreenWidth, height: 10)
        }
        else if(section == 6) {
            //灰条
            return CGSize(width: RXScreenWidth, height: 100)
        }
        return CGSize()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = indexPath.section
        if(section == 1 || section == 3 || section == 3 || section == 5) {
            //不可点击
            return
        }
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
            self.collectionView.reloadSections(IndexSet(integer: 4))
        }
    
        homeLoadRequestVM.homeRequetSkill {
            self.collectionView.reloadSections(IndexSet(integer: 4))
        }

        homeLoadRequestVM.homeRequetIndexTV {
            self.collectionView.reloadSections(IndexSet(integer: 6))
        }

    }
}

// MARK: --- 处理事件 -----
extension RXHomeViewController : RXHomeBuyerPlayerCellDelegate, RXHomeMarketingCellDelegate {
    func homeMarketionCellClick(_ rowKey: String, row:Int) {
        RXLog("点击icon key=\(rowKey)  \(row)")
    }
    
    func homeBuyerPlayerTimeOut() {
        RXLog("秒杀的倒计时为0了哦")
    }
    
    func homeBuyerPlayerClick(_ type: CellType, _ skill_id: String) {
        RXLog("点击了 秒杀、买手、玩家 \(type)")
        let sharkPlayerVC = RXSharkPlayerController()
        navigationController?.pushViewController(sharkPlayerVC, animated: true)
    }
    
}

