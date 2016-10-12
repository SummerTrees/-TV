//
//  RecommendViewController.swift
//  DouYuTV
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Foundation

private let kMargin : CGFloat = 10
private let kItemSizeW : CGFloat = (kScreenW - 3 * kMargin) / 2
private let kNomalItemSizeH : CGFloat = kItemSizeW * 3 / 4
private let kPrettyItemSizeH : CGFloat = kItemSizeW * 4 / 3
private let kSectionHeaderH : CGFloat = 50

private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH : CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeadViewID = "kHeadViewID"

class RecommendViewController: UIViewController{

    private lazy var collectView : UICollectionView = {
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemSizeW, height: kNomalItemSizeH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = kMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]

        //注册cell
        collectionView.registerNib(UINib.init(nibName: "RecommentNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.registerNib(UINib.init(nibName: "RecommendPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.registerNib(UINib.init(nibName: "CollectionSHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

}

// MARK:UI
extension RecommendViewController {
    private func setupUI() {
        
        view.addSubview(collectView)
    
    
    }


}


// MARK:
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let prettyCell = collectionView.dequeueReusableCellWithReuseIdentifier(kPrettyCellID, forIndexPath: indexPath)
            return prettyCell
        } else {
            
            let nomalCell = collectionView.dequeueReusableCellWithReuseIdentifier(kNormalCellID, forIndexPath: indexPath)
            return nomalCell
        }

    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: kHeadViewID, forIndexPath: indexPath) as! CollectionSHeaderView
        
        // 2.取出模型
        
        
        return headerView
    }
    
    
    
   
    
    

}

// MARK:
extension RecommendViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemSizeW, height: kPrettyItemSizeH)
        }
        return CGSize(width: kItemSizeW, height: kNomalItemSizeH)
    }

}

