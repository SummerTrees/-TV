//
//  HomeViewController.swift
//  DouYuTV
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

private let kTitleH : CGFloat = 40

class HomeViewController: UIViewController {
    
    fileprivate var titles : [String] = ["推荐","娱乐","游戏","趣玩"]
    

    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
        let titleFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kTitleH)
        let pageTitleView : PageTitleView = PageTitleView(frame: titleFrame, titles: (self?.titles)!)
        pageTitleView.delegate = self
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
       
        let contentFrame = CGRect(x: 0, y: kNavigationBarH + kTitleH + kStatusBarH, width: kScreenW, height: kScreenH - kNavigationBarH - kTitleH - kStatusBarH - kTabbarH)
        let vcCount : Int = self!.titles.count - 1
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<vcCount{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        
        }
        
        let pageContentView :  PageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        
        pageContentView.delegate = self
        
        return pageContentView
    
    }()
    
    
    
    override func viewDidLoad() {
        
        setupUI()
        
    }
}

// MARK: 设置UI
extension HomeViewController {
    
    // MARK: 设置UI
    fileprivate func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加标题和内容
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        
        
    }
    
    
    fileprivate func setupNavigationBar() {
        setupNavigationLeftBar()
        setupNavigationRightBar()
    }
    fileprivate func setupNavigationLeftBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo", target: self, action: #selector(self.leftItemClick))
    }
    fileprivate func setupNavigationRightBar() {
        let size = CGSize(width: 40, height: 44)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: size, target: self, action: #selector(self.historyItemClick))
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_click", size: size, target: self, action: #selector(self.searchItemClick))
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size, target: self, action: #selector(self.qrCodeItemClick))
        navigationItem.rightBarButtonItems = [historyItem, searchItem , qrCodeItem]
    }
    
}

// MARK: pageTitleViewDelegate
extension HomeViewController : pageTitleViewDelegate {

    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        
        pageContentView.scrollToIndex(index)
        
    }


}

// MARK: PageContentViewDelegate
extension HomeViewController : PageContentViewDelegate {
    
    func pageContentView(_ contentView: PageContentView, scrollProgress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.setCurrentLabel(sourceIndex, targetIndex: targetIndex, progress: scrollProgress)
        
    }
    
}




// MARK:点击事件
extension HomeViewController {
    
    @objc fileprivate func leftItemClick() {
        print("点击了logo")
    }

    @objc fileprivate func qrCodeItemClick() {
        print("点击了二维码")
    }
    @objc fileprivate func searchItemClick() {
        print("点击了搜索")
    }
    @objc fileprivate func historyItemClick() {
        print("点击了历史")
    }

}




