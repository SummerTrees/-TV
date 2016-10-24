
//
//  RecommendCycleView.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"
class RecommendCycleView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cycleTimer : Timer?
    
    var recommendCycleModels : [RecommendCycleModel]? {
        didSet {
            //1.刷新数据
            collectionView.reloadData()
            
            //2.设置pagecontrol
            pageControl.numberOfPages = recommendCycleModels?.count ?? 0
            
            //3.默认滚到中间的位置
            let indexPath = IndexPath(item: recommendCycleModels?.count ?? 0 * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeTimer()
            addTimer()
            
            
        }
    
    
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib.init(nibName: "RecommendCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let width = collectionView.bounds.size.width - 0.01
        let height = collectionView.bounds.size.height
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }
}

// MARK:类工厂方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
        
    }

}

// MARK:UICollectionViewDataSource
extension RecommendCycleView : UICollectionViewDataSource{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (recommendCycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cycleCell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! RecommendCycleCell
        cycleCell.cycleModel = recommendCycleModels![indexPath.item % recommendCycleModels!.count]
        
        return cycleCell
    }

}

extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width) % (recommendCycleModels?.count ?? 1)
        
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }

}

extension RecommendCycleView {
    
    fileprivate func addTimer() {
        cycleTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.scrollToNext) , userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoopMode.commonModes)
        
    }
    
    fileprivate func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc fileprivate func scrollToNext() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
    }
}
