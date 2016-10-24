
//
//  RecommendGameView.swift
//  DouYuTV
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kGameCellWH = 80
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [BaseGroupModel]? {
        didSet {
        
            collectionView.reloadData()
            
        }
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        
        // 注册Cell
        collectionView.register(UINib(nibName: "RecommendGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
    }

    
}



// MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}


// MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! RecommendGameCell
        
        cell.gameModel = groups![(indexPath as NSIndexPath).item]
        
        return cell
    }
}
