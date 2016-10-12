//
//  PageContentView.swift
//  DouYuTV
//
//  Created by mac on 16/9/24.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class{
    func pageContentView(contentView : PageContentView, scrollProgress : CGFloat,sourceIndex : Int, targetIndex : Int)
}


private let kContentCellID = "contengCell"

class PageContentView: UIView {
    
    // MARK:定义属性
    private var childVcs : [UIViewController]
    private var parentVc : UIViewController?
    private var isTapGesture : Bool = false
    private var startOffsetX : CGFloat = 0
    weak var delegate : PageContentViewDelegate?
    
    
    // MARK:懒加载属性
    private lazy var collectionView : UICollectionView = {
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        //2.创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        return collectionView
    }()

    init(frame: CGRect, childVcs : [UIViewController], parentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        
        //设置UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK:设置UI
extension PageContentView {

    private func setupUI() {
        //1.添加子控制器
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        
        // 2.添加collectionView
        addSubview(collectionView)
        collectionView.frame = bounds
    
    }  

}

//MARK:UICollectionViewDataSource
extension PageContentView :UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let contentCell = collectionView.dequeueReusableCellWithReuseIdentifier(kContentCellID, forIndexPath: indexPath)
        
                //重复利用问题
                for view in contentCell.contentView.subviews {
                    view.removeFromSuperview()
                }
        
                let childVc = childVcs[(indexPath as NSIndexPath).item]
                childVc.view.frame = contentCell.contentView.bounds
                contentCell.contentView.addSubview(childVc.view)
                
                return contentCell
    }
    
    
    
   


}


// MARK:UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //不是点击事件
        isTapGesture = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
   
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isTapGesture { return }
        
        //0.定义变量
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //1.判断滑动
        let scrollViewW : CGFloat = scrollView.bounds.width
        let offsetX = scrollView.contentOffset.x
        let radio = offsetX / scrollViewW
        
        if offsetX > startOffsetX {//左滑
            //1.计算progress
            progress = radio - floor(radio)
            
            //2.计算sourceIndex
            sourceIndex = Int(offsetX / scrollViewW)
            
            //3.计算targetIndex(注意角标越界)
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            //4.如果完全划过去
            if offsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {
            //1.计算progress
            progress = 1 - (radio - floor(radio))
            
            //2.计算targetIndex(注意角标越界)
            targetIndex = Int(offsetX / scrollViewW)
            
            //3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        //2.通知代理
        delegate?.pageContentView(self, scrollProgress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}

// MARK:对外暴露的方法
extension PageContentView {
    func scrollToIndex(index : Int) {
        //点击手势,不进入滑动方法,避免混乱
        isTapGesture = true
        
        let offset = CGPoint(x: CGFloat(index) * collectionView.bounds.size.width, y: 0)
        collectionView.setContentOffset(offset, animated: false)
        
    }

}









