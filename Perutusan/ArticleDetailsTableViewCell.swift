//
//  ArticleDetailsTableViewCell.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/9/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit
import SnapKit

class ArticleDetailsTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    func configure(article article: Article) {
        let darkTextColor = UIColor(hexString: "#333333")
        let lightTextColor = UIColor(hexString: "#999999")
        
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textColor = darkTextColor
        titleLabel.font = UIFont.systemFontOfSize(30, weight: UIFontWeightBlack)
        titleLabel.text = article.title
        contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
        }
        
        
        let timestampImageView = UIImageView(image: R.image.timestamp())
        contentView.addSubview(timestampImageView)
        
        timestampImageView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(16)
            make.height.equalTo(16)
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(4)
            make.bottom.equalTo(contentView).offset(-15)
        }
        
        
        let timestampLabel = UILabel()
        timestampLabel.text = article.timestamp.uppercaseString
        timestampLabel.textColor = lightTextColor
        timestampLabel.font = UIFont.systemFontOfSize(12)
        contentView.addSubview(timestampLabel)
        
        timestampLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(timestampImageView)
            make.leading.equalTo(timestampImageView.snp_trailing).offset(8)
        }
    }

}
