//
//  RXImageScroller.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/3/30.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//轮播图  --因为现在还没有要设计网络，就没有数据模型和数据

import UIKit
import Kingfisher

let IMGSIdentifer = "IMGS_cell"

class RXImageScroller: UIView {
    // MARK: 定义属性
    var cycleTimer : Timer?
    var cycleModels : [RXImageScrollModel]? {
        didSet {
            // 1.刷新collectionView
            collectionView.reloadData()
            
            // 2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            pageControl.currentPage = 0
            
            // 3.默认滚动到中间某一个位置
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
//            // 4.添加定时器
            removeCycleTimer()
            if(pageControl.numberOfPages == 0) { return }
            addCycleTimer()
        }
    }
    //分页
    fileprivate lazy var pageControl : RXPageControl = { [unowned self] in
        let pageControl = RXPageControl()
        let height = self.bounds.size.height
        let width = self.bounds.size.width
        pageControl.frame = CGRect(x: 0, y:height-15 , width: width, height: 10)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 0;
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.scrollDirection = .horizontal
        flowlayout.itemSize = self.bounds.size
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowlayout)
        collectionView.delegate = self
        collectionView.dataSource = self;
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.register(ImageScrollerCell.classForCoder(), forCellWithReuseIdentifier: IMGSIdentifer)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 遵守UICollectionView的数据源协议
extension RXImageScroller: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModels?.count ?? 0)*1000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IMGSIdentifer, for: indexPath) as! ImageScrollerCell
        cell.scrollModel = cycleModels![(indexPath as NSIndexPath).item % cycleModels!.count]
        return cell
    }
    
}

// MARK:- 遵守UICollectionView的代理协议
extension RXImageScroller: UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        // 2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
//
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        RXLog("点击了 轮播图第\(row)张")
    }
}


// MARK:- 对定时器的操作方法
extension RXImageScroller {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
    }
    
    fileprivate func removeCycleTimer() {
        cycleTimer?.invalidate() // 从运行循环中移除
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        // 1.获取滚动的偏移量
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        // 2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}




fileprivate class ImageScrollerCell: UICollectionViewCell {
    fileprivate lazy var imgView : UIImageView = { [unowned self] in
        let imgView = UIImageView(frame: self.bounds)
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgView)
    }
    
    // MARK: 定义模型属性
    var scrollModel : RXImageScrollModel? {
        didSet {
            let iconURL = URL(string: scrollModel?.image ?? "")!
            imgView.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: --- 分页控制器 -----
fileprivate class RXPageControl : UIView {
    /// 控件间距离
    var dotSpace : CGFloat = 10
    /// 选择的控件大小
    var dotDiameterOn : CGFloat = 8
    /// 未选择的控件的大小
    var dotDiameterOff : CGFloat = 5
    /// 选择的控件颜色
    var onColor : UIColor = UIColor.white
    /// 未选择的控件颜色
    var offColor : UIColor = UIColor.white
    
    fileprivate var nomalTransform = CGAffineTransform()
    /// 数组存储
    fileprivate var dotArrayM = [UIView]()
    
    /// 当前页数
    var currentPage : Int = 0 {
        didSet {
            
            if(numberOfPages == 0) { return }
            
            if(currentPage >= numberOfPages) {
                currentPage = 0
            }
            changeSelectedPage()
        }
    }
    
    /// 总页数
    var numberOfPages : Int = 0 {
        didSet {
            removeAll()
            guard numberOfPages != 0 else { return }
            createSubPageControll()
        }
    }
    
    fileprivate func removeAll() {
        for view in subviews {
            view.removeFromSuperview()
        }
        
        dotArrayM.removeAll()
    }
    
    //MARK: - 创建字分页控制器
    fileprivate func createSubPageControll() {
        
        if(numberOfPages == 0) { return }
        
        let width = self.bounds.size.width
        let count : CGFloat = CGFloat(numberOfPages) - 1
        let middle = (width-dotDiameterOff*count-dotDiameterOn-count*dotSpace)/2
        
        for i in 0..<numberOfPages {
            let index = CGFloat(i)
            let x : CGFloat = index*dotDiameterOff+index*dotSpace+middle
            let dotView = UIView(frame: CGRect(x: x, y: 0, width: dotDiameterOff, height: dotDiameterOff)) 
            //解包
            dotView.layer.cornerRadius = dotDiameterOff/2.0
            dotView.backgroundColor = offColor
            dotView.tag = i
            addSubview(dotView)
            if(i == 0) {
                //只赋一次值
                nomalTransform = dotView.transform
            }
            dotArrayM.append(dotView)
        }
    }
    
    //MARK: - 选中某个
    fileprivate func changeSelectedPage() {
        
        guard currentPage>=0 && currentPage<dotArrayM.count else {
            //无效
            return
        }
        
        let diffTransform =  (dotDiameterOn - dotDiameterOff)/dotDiameterOff
        
        for dotView in dotArrayM {
            if(dotView.tag == currentPage) {
                dotView.transform = CGAffineTransform(scaleX: 1+diffTransform, y: 1+diffTransform)
                dotView.backgroundColor = onColor
            }
            else {
                dotView.transform = nomalTransform
                dotView.backgroundColor = offColor
            }
        }
    }
}
