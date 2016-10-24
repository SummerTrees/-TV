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
    // MARK:- 懒加载属性
    fileprivate lazy var collectView : UICollectionView = {
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemSizeW, height: kNomalItemSizeH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = kMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kSectionHeaderH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        //注册cell
        collectionView.register(UINib.init(nibName: "RecommentNomalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "RecommendPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        
        collectionView.register(UINib.init(nibName: "CollectionSHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        
        return collectionView
    }()
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        return cycleView;
    }()
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView;
    }()
    fileprivate lazy var recommendViewModel : RecommendViewModel = RecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
        
    }

}

// MARK:UI
extension RecommendViewController {
    fileprivate func setupUI() {
        
        view.addSubview(collectView)
        collectView.addSubview(cycleView)
        collectView.addSubview(gameView)
        collectView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    
    }


}

// MARK:- 请求数据
extension RecommendViewController {
    func loadData() {
        recommendViewModel.requestData { 
            self.collectView.reloadData()
            
            //2.处理游戏推荐部分
            
            //2.1 移除
            var groups = self.recommendViewModel.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            //2.2 添加更多
            let moreGroup = AnchorGroupItem()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            //3.数据传递
            self.gameView.groups = groups
        }
        
        recommendViewModel.requestCycleData { 
            self.cycleView.recommendCycleModels = self.recommendViewModel.cycleModels
        }
    }



}



// MARK:
extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendViewModel.anchorGroups[section].anchorArray.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath as NSIndexPath).section == 1 {
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! RecommendPrettyCell
            prettyCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchorArray[indexPath.item]
            return prettyCell
        } else {
            
            let nomalCell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! RecommentNomalCell
            nomalCell.anchor = recommendViewModel.anchorGroups[indexPath.section].anchorArray[indexPath.item]
            return nomalCell
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionSHeaderView
        
        // 2.取出模型
        headerView.groupItem = recommendViewModel.anchorGroups[indexPath.section]
        
        return headerView
    }

}

// MARK:
extension RecommendViewController : UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1 {
            return CGSize(width: kItemSizeW, height: kPrettyItemSizeH)
        }
        return CGSize(width: kItemSizeW, height: kNomalItemSizeH)
    }

}

