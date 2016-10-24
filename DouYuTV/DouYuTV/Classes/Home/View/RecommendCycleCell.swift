//
//  RecommendCycleCell.swift
//  DouYuTV
//
//  Created by mac on 16/10/13.
//  Copyright © 2016年 mac. All rights reserved.
//

import UIKit
import Kingfisher

class RecommendCycleCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var cycleModel : RecommendCycleModel? {
        didSet {
            nameLabel.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage.init(named: "Img_default"))
        
        }
    
    }
    

}
