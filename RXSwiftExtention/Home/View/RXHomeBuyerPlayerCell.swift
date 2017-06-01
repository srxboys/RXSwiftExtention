//
//  RXHomeBuyerPlayerCell.swift
//  RXSwiftExtention
//
//  Created by srx on 2017/4/2.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//秒杀、买手、玩家_banner

import UIKit
import Kingfisher

let HomeBuyerPlayerCellId = "HBPCI"

enum CellType : Int {
    case CellType_Skil = 0
    case CellType_Buyer = 1
    case CellType_Player = 2
}

enum CellSkilTimeType : Int {
    case CellSkilTime_noStart = 0 //未开始
    case CellSkilTime_expire = 1 //已播出
    case CellSkilTime_doing = 2 //开始倒计时
}

protocol RXHomeBuyerPlayerCellDelegate : class {
    func homeBuyerPlayerTimeOut()
    func homeBuyerPlayerClick(_ type:CellType,_ skill_id:String)
}

class RXHomeBuyerPlayerCell: UICollectionViewCell {
    weak var delegate : RXHomeBuyerPlayerCellDelegate?
    
    fileprivate lazy var skilView : CellSkillView = { [weak self] in
        let width = self?.contentView.bounds.width ?? 0
        let height = self?.contentView.bounds.height ?? 0
        let skilView = CellSkillView()
        skilView.frame = CGRect(x: 0, y: 0, width: width/2.0-0.25, height: height)
        skilView.addSubviewUI()
        skilView.changeSubViewFrame(viewFrame: skilView.frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(skillClick))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        skilView.addGestureRecognizer(tap)
        return skilView
    }()
    fileprivate lazy var buyerImg : UIImageView = { [weak self] in
        
        let width = self?.contentView.bounds.width ?? 0
        let height = self?.contentView.bounds.height ?? 0
        let buyerImg = UIImageView()
        buyerImg.frame = CGRect(x: width/2.0+0.25, y: 0, width: width/2.0, height: height/2.0-0.25)
        buyerImg.backgroundColor = UIColor.white
        buyerImg.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(buyerClick))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        buyerImg.addGestureRecognizer(tap)
        return buyerImg
    }()
    
    fileprivate lazy var playerImg : UIImageView = { [weak self] in
        let width = self?.contentView.bounds.width ?? 0
        let height = self?.contentView.bounds.height ?? 0
        let playerImg = UIImageView()
        playerImg.frame = CGRect(x: width/2.0+0.25, y:height/2.0+0.25, width: width/2.0, height: height/2.0-0.25)
        playerImg.isUserInteractionEnabled = true
        playerImg.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer(target: self, action: #selector(playerClick))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        playerImg.addGestureRecognizer(tap)
        return playerImg
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.lightGray
        contentView.addSubview(skilView)
        contentView.addSubview(buyerImg)
        contentView.addSubview(playerImg)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: --- 事件监听 -----
extension RXHomeBuyerPlayerCell {
    @objc func skillClick() {
        delegate?.homeBuyerPlayerClick(.CellType_Skil, "")
    }
    
    @objc func buyerClick() {
        delegate?.homeBuyerPlayerClick(.CellType_Buyer, "")
    }
    
    @objc func playerClick() {
        delegate?.homeBuyerPlayerClick(.CellType_Player, "")
    }
}

extension RXHomeBuyerPlayerCell {
    func setBuyerPlayerModel(bpArr:[String]) {
        if(!bpArr.isEmpty) {
            for i in 0..<bpArr.count {
                if(i > 1) { return }
                let image = bpArr[i]
                let url = URL(string: image)
                if(i == 0) {
                    buyerImg.kf.setImage(with: url)
                }
                else {
                    playerImg.kf.setImage(with: url)
                }
            }
        }
    }
    
    func setSkillModel(model : RXSkillModel) {
        skilView.skillModel = model
    }
}

// MARK: --- <#Nodes#> -----
// MARK: --- <#Nodes#> -----
// MARK: --- 秒杀view -----

protocol CellSkillViewDelegate {
    func cellSkillViewTimeOut(_ type:CellSkilTimeType)
}

class CellSkillView: UIView {
    var delegate : CellSkillViewDelegate?
    
    fileprivate lazy var timer: Timer? = Timer()
    fileprivate lazy var timeSingeDateInt : Int = 0
    fileprivate lazy var timeType = CellSkilTimeType.CellSkilTime_noStart
    /// 商品图
    fileprivate lazy var imgView : UIImageView = {[weak self] in
        let imgView = UIImageView(frame: self?.bounds ?? CGRect())
        return imgView
    }()
    
    /// 限时抢购
    fileprivate lazy var titleLabel : UILabel = {[weak self] in
        let titleLabel = self?.setLabel("限时闪购", fontSize: 16, color: UIColor.colorHex("D0021B")) ?? UILabel()
        return titleLabel
    }()
    
    /// >
    fileprivate lazy var arrowImg : TriangleView = {[weak self] in
        let arrowImg = TriangleView()
        arrowImg.backgroundColor = UIColor.clear
        return arrowImg
    }()

    /// 小时
    fileprivate lazy var hourLabel : UILabel = {[weak self] in
        let hourLabel = self?.setLabel("", fontSize: 14, color: UIColor.white) ?? UILabel()
        hourLabel.backgroundColor = UIColor.black
        return hourLabel
    }()
    
    fileprivate lazy var hourMinLabel : UILabel = {[weak self] in
        let hourMinLabel = self?.setLabel(":", fontSize: 10, color: UIColor.black) ?? UILabel()
        hourMinLabel.font = UIFont.boldSystemFont(ofSize: 12)
        hourMinLabel.backgroundColor = UIColor.clear
        return hourMinLabel
    }()
    
    /// 分钟
    fileprivate lazy var minLabel : UILabel = {[weak self] in
        let minLabel = self?.setLabel("", fontSize: 14, color: UIColor.white) ?? UILabel()
        minLabel.backgroundColor = UIColor.black
        return minLabel
    }()
    
    fileprivate lazy var minSecondLabel : UILabel = {[weak self] in
        let minSecondLabel = self?.setLabel(":", fontSize: 10, color: UIColor.black) ?? UILabel()
        minSecondLabel.font = UIFont.boldSystemFont(ofSize: 12)
        minSecondLabel.backgroundColor = UIColor.clear
        return minSecondLabel
        }()
    
    /// 秒
    fileprivate lazy var secondLabel : UILabel = {[weak self] in
        let secondLabel = self?.setLabel("", fontSize: 14, color: UIColor.white) ?? UILabel()
        secondLabel.backgroundColor = UIColor.black
        return secondLabel
    }()
    
    /// 标签
    fileprivate lazy var tagImg : UIImageView = {[weak self] in
        let tagImg = UIImageView()
        return tagImg
    }()
    
    fileprivate var skillModel : RXSkillModel = RXSkillModel() {
        didSet {
            reloadSkillView()
        }
    }
}

extension CellSkillView {
    /// 添加控件
    func addSubviewUI() {
        backgroundColor = UIColor.white
        addSubview(imgView)
        addSubview(titleLabel)
        addSubview(arrowImg)
        addSubview(hourLabel)
        addSubview(hourMinLabel)
        addSubview(minLabel)
        addSubview(minSecondLabel)
        addSubview(secondLabel)
    }
   
    /// 更改子控件坐标
    func changeSubViewFrame(viewFrame:CGRect) {
        let width = viewFrame.size.width
        let height = viewFrame.size.height
        var top : CGFloat = 14
        var titleFrame = CGRect(x: 0, y: top, width: width, height: 16)
        let titleWidth = titleLabel.textRect(forBounds: titleFrame, limitedToNumberOfLines: 1).size.width
        let arrowImgWidth : CGFloat = 5
        let arrowImgLeft : CGFloat = 4
        let arrowImgHeight : CGFloat = 7
        let titleX = (width - titleWidth - arrowImgLeft - arrowImgWidth)/2.0
        titleFrame = CGRect(x: titleX, y: top, width: titleWidth, height: 16)
        titleLabel.frame = titleFrame
        
        let arrowImgX = titleX + titleWidth + arrowImgLeft
        arrowImg.frame = CGRect(x: arrowImgX, y: top, width: arrowImgWidth, height: arrowImgHeight)
        arrowImg.center = CGPoint(x: arrowImg.center.x, y: titleLabel.center.y)
        
        
        top += 16 + 7
        let timeWith : CGFloat = 25
        let timeHeight : CGFloat = 20
        let colon : CGFloat = 9
        var timeX : CGFloat = (width-(timeWith*3)-(colon*2))/2.0
        //时
        hourLabel.frame = CGRect(x: timeX, y: top, width: timeWith, height: timeHeight)
        hourLabel.text = "00"
        
        timeX += timeWith
        hourMinLabel.frame = CGRect(x: timeX, y: top, width: colon, height: timeHeight)
        timeX += colon
        //分
        minLabel.frame = CGRect(x: timeX, y: top, width: timeWith, height: timeHeight)
        minLabel.text = "00"
        
        timeX += timeWith
        minSecondLabel.frame = CGRect(x: timeX, y: top, width: colon, height: timeHeight)
        timeX += colon
        //秒
        secondLabel.frame = CGRect(x: timeX, y: top, width: timeWith, height: timeHeight)
        secondLabel.text = "00"
    
        top += timeHeight + 7
        
    }
    
    /// 统一初始化UILabel
    fileprivate func setLabel(_ title:String, fontSize:CGFloat, color:UIColor) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.textAlignment = .center
        return label
    }
    
    fileprivate func reloadSkillView() {
        if(skillModel.id.isEmpty) { return }
        titleLabel.text = skillModel.title
        
        let url = URL(string: skillModel.image)
        imgView.kf.setImage(with: url)
        
        timeWithString(skillModel.now, startTimer: skillModel.startTime, endTimer: skillModel.endTime)
    
    }
    
    fileprivate func timeWithString(_ currentTimer:String, startTimer:String, endTimer:String) {
        let currentTime = timeStampToDate(currentTimer)
        let startTime = timeStampToDate(startTimer)
        let endTime = timeStampToDate(endTimer)
        
        timeTimeOut(timeType)
        
        if(endTime.compare(currentTime) == ComparisonResult.orderedAscending) {
            //时间已过期
            timeType = .CellSkilTime_expire
            
        }
        else if(startTime.compare(currentTime) == .orderedDescending) {
            //未开始
            timeType = .CellSkilTime_noStart
        }
        else {
            //开始倒计时
            timeType = .CellSkilTime_doing
            timeSingeDateInt = Int(endTime.timeIntervalSince1970 - currentTime.timeIntervalSince1970)
            let object = timeStampToString(timeSingeDateInt)
            hourLabel.text = object.hour
            minLabel.text = object.mintes
            secondLabel.text = object.seconds
            let interval : Double = 1
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)

            let runLoopTime = RunLoop.main
            runLoopTime.add(timer!, forMode: .commonModes)
//            runLoopTime.run() //这个是针对RunLoop()方法的，不是main 的RunLoop
            timer?.fireDate = .distantPast

        }
    }
    
    fileprivate func timeStampToDate(_ time:String) -> Date {
        let string = NSString(string: time)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="HH:mm:ss"
        dfmatter.date(from: time)
        return Date(timeIntervalSince1970: timeSta)
    }
    
    fileprivate func timeStampToString(_ time:Int) -> (hour:String, mintes:String, seconds:String) {
        let hours : Int = time/3600
        let mintes : Int = time%3600/60
        let seconds : Int = time%60
        let timeString = String(format: "%02ld:%02ld:%02ld", hours, mintes, seconds)
        let array = timeString.components(separatedBy: ":")
        return (array[0], array[1], array[2])
    }
    
    @objc fileprivate func startCountDown() {
        timeSingeDateInt -= 1
        
        if(timeSingeDateInt <= 0) {
            timeTimeOut(.CellSkilTime_expire)
            return
        }
        let object = timeStampToString(timeSingeDateInt)
        hourLabel.text = object.hour
        minLabel.text = object.mintes
        secondLabel.text = object.seconds
    }
    
    fileprivate func timeTimeOut(_ type : CellSkilTimeType) {
        if(timer != nil) {
            //防止崩溃
            timer?.invalidate()
            timer = nil
        }

        hourLabel.text = "00"
        minLabel.text = "00"
        secondLabel.text = "00"
        delegate?.cellSkillViewTimeOut(type)
    }
}


class TriangleView : UIView {
    override func draw(_ rect: CGRect) {
        if let ctx = UIGraphicsGetCurrentContext() {
            ctx.setFillColor(UIColor.colorHex("D0021B").cgColor)
//            ctx.setStrokeColor(UIColor.white.cgColor)
            ctx.setLineWidth(0.1)
            ctx.move(to: CGPoint(x: 0, y: 0))
            ctx.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/2.0))
            ctx.addLine(to: CGPoint(x: 0, y: rect.size.height))
            ctx.drawPath(using: .fill)
            UIGraphicsEndImageContext()
        }
    }
}




