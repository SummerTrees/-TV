//
//  RecommendGameCell.swift
//  DouYuTV
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit

class RecommendGameCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.bounds.size.width * 0.5 - 0.1
        iconImageView.layer.masksToBounds = true

    }
    
    
    var gameModel : BaseGroupModel? {
        didSet {
            nameLabel.text = gameModel?.tag_name
            
            if let iconURL = URL(string: gameModel?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }

            
        }
    
    }
    
}
