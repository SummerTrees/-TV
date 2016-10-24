

//
//  RecommendBaseCell.swift
//  DouYuTV
//
//  Created by mac on 16/10/12.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendBaseCell: UICollectionViewCell {
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var onlineBtn: UIButton!
    
    
    // MARK:模型
    var anchor : AnchorItem? {
        didSet {
            
            guard let anchor = anchor else{ return }
            
            //1.在线人数
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(anchor.online / 10000)万"
            }else {
                onlineStr = "\(anchor.online)人"
            }
            onlineBtn.setTitle(onlineStr, for: UIControlState())
            
            //2.房主昵称
            nickNameLabel.text = anchor.nickname
            
            //3.房间图片
            guard let iconUrl = URL(string : anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconUrl)
        
        }
    }
    
    
    
}
