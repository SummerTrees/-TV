//
//  PageTitleView.swift
//  DouYuTV
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Foundation

// MARK:协议
protocol pageTitleViewDelegate : class {
    func pageTitleView(titleView : PageTitleView, selectedIndex index : Int)
}

// MARK:- 定义常量
private let kScrollLineH : CGFloat = 2
private let kNormalRGB : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectRGB : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kDeltaRGB = (kSelectRGB.0 - kNormalRGB.0, kSelectRGB.1 - kNormalRGB.1, kSelectRGB.2 - kNormalRGB.2)
private let kNormalTitleColor = UIColor(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0)
private let kSelectTitleColor = UIColor(red: 255.0/255.0, green: 128/255.0, blue: 0/255.0, alpha: 1.0)

class PageTitleView: UIView {

    // MARK:定义属性
    private var currentIndex : Int = 0
    private var titles : [String]
    weak var delegate : pageTitleViewDelegate?
    
    
    // MARK:懒加载
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    // MARK:自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

// MARK:- 设置UI界面
extension PageTitleView {

    private func setupUI() {
    //1.添加scrollView
    addSubview(scrollView)
    scrollView.frame = bounds
    
    
    // 2.添加title对应的Label
    setupTitleLabels()
    
    // 3.设置底线和滚动的滑块
    setupBottomLineAndScrollLine()
    
    
    }
    
    
    private func setupTitleLabels() {
        
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index,title) in titles.enumerate() {
            // 1.创建UILabel
            let label = UILabel()
            
            // 2.设置Label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFontOfSize(16)
            label.textColor = kNormalTitleColor
            label.textAlignment = .Center
            
            // 3.设置label的frame
            let labelX = CGFloat(index) * labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 4.将label添加到scrollView中
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            print(label.tag,index)
            
            // 5.添加手势
            label.userInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action:#selector(self.titleLabelClick(_:)) )
            label.addGestureRecognizer(tap)
            
        }   
        
    }
    
    private func setupBottomLineAndScrollLine() {
        //1.设置底部的线
        let bottomLine = UIView()
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        addSubview(bottomLine)
        
        //2.添加scrollLine
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = kSelectTitleColor
        // 2.2.设置scrollLine的属性
        addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.size.width, height: kScrollLineH)
    }
}

// MARK:- 监听Label的点击
extension PageTitleView {

    @objc private func titleLabelClick(tap : UITapGestureRecognizer) {
    
        print("点击了label")
        //0.获取当前的label
        guard let currentLabel = tap.view as? UILabel else {return}
        
        //1.如果是同一个不处理
        print(currentLabel.tag)
        print(currentIndex)
        if currentLabel.tag == currentIndex {return}
        
        //2.获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        // 3.切换文字的颜色
        currentLabel.textColor = kSelectTitleColor
        oldLabel.textColor = kNormalTitleColor
        
        //4.保存下标
        currentIndex = currentLabel.tag
        print(currentIndex,currentLabel.tag)
        
        //5.滚动条
        let scrollLineX = currentLabel.frame.origin.x
        UIView.animateWithDuration(0.3) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }

        //6.通知代理
        delegate?.pageTitleView(self, selectedIndex: currentIndex)
    
    }
}

// MARK:- 对外暴露的方法
extension PageTitleView {
    
    func setCurrentLabel(sourceIndex : Int, targetIndex : Int, progress : CGFloat) {
        //1.取出响应的Label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块
        let totalMoveX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = totalMoveX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.颜色渐变
        sourceLabel.textColor = UIColor(r: kSelectRGB.0 - kDeltaRGB.0 * progress, g: kSelectRGB.1 - kDeltaRGB.1 * progress, b: kSelectRGB.2 - kDeltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalRGB.0 + kDeltaRGB.0 * progress, g: kNormalRGB.1 + kDeltaRGB.1 * progress, b: kNormalRGB.2 + kDeltaRGB.2 * progress)
        
        //4.记录index
        currentIndex = targetIndex
        
    }
    

}




