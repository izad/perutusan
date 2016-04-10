//
//  ArticleDetailsTableViewCell.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/9/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

class ArticleDetailsTableViewCell: UITableViewCell {
    
    var delegate: ArticleDetailsTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }

    func configure(article article: Article, delegate: ArticleDetailsTableViewCellDelegate) {
        self.delegate = delegate
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
        
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
        
        
        let topGuideView = UIView()
        contentView.addSubview(topGuideView)
        
        if article.loaded {            
            topGuideView.snp_makeConstraints { (make) in
                make.left.equalTo(contentView)
                make.top.equalTo(timestampImageView.snp_bottom)
                make.right.equalTo(contentView)
                make.height.equalTo(1)
            }
            
            if let photoURL = article.photoURL {
                let photoImageView = UIImageView()
                photoImageView.userInteractionEnabled = true
                photoImageView.af_setImageWithURL(photoURL)
                photoImageView.contentMode = .ScaleAspectFill
                photoImageView.clipsToBounds = true
                photoImageView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                
                let recognizer = UITapGestureRecognizer(target: self, action: #selector(photoImageViewTapped(_:)))
                photoImageView.addGestureRecognizer(recognizer)
                
                contentView.addSubview(photoImageView)
                
                photoImageView.snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(topGuideView.snp_bottom).offset(15)
                    make.left.equalTo(contentView)
                    make.right.equalTo(contentView)
                })
                
                if let caption = article.caption {
                    let captionLabel = UILabel()
                    captionLabel.text = caption
                    captionLabel.numberOfLines = 0
                    captionLabel.textColor = lightTextColor
                    captionLabel.font = UIFont.systemFontOfSize(12)
                    contentView.addSubview(captionLabel)
                    
                    captionLabel.snp_makeConstraints(closure: { (make) in
                        make.left.equalTo(contentView).offset(15)
                        make.right.equalTo(contentView).offset(-15)
                        make.top.equalTo(photoImageView.snp_bottom).offset(8)
                    })
                }
            }
            
            if let lead = article.lead {
                let leadLabel = UILabel()
                leadLabel.text = lead
                leadLabel.numberOfLines = 0
                leadLabel.textColor = darkTextColor
                leadLabel.font = UIFont.systemFontOfSize(14)
                contentView.addSubview(leadLabel)
                
                leadLabel.snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(contentView.previousSubview.snp_bottom).offset(15)
                    make.left.equalTo(contentView).offset(15)
                    make.right.equalTo(contentView).offset(-15)
                }
            }
            
            if let body = article.body {
                let bodyLabel = UILabel()
                
                if let author = article.author {
                    bodyLabel.text = "\(body)Author: \(author)\n\n"
                }
                else {
                    bodyLabel.text = body
                }
                
                bodyLabel.numberOfLines = 0
                bodyLabel.textColor = darkTextColor
                bodyLabel.font = UIFont.systemFontOfSize(14)
                contentView.addSubview(bodyLabel)
                
                bodyLabel.snp_makeConstraints { (make) -> Void in
                    make.top.equalTo(contentView.previousSubview.snp_bottom).offset(15)
                    make.left.equalTo(contentView).offset(15)
                    make.right.equalTo(contentView).offset(-15)
                }
            }
            
            let bottomGuideView = UIView()
            contentView.addSubview(bottomGuideView)
            
            bottomGuideView.snp_makeConstraints { (make) in
                make.left.equalTo(contentView)
                make.top.equalTo(contentView.previousSubview.snp_bottom)
                make.right.equalTo(contentView)
                make.height.equalTo(1)
                make.bottom.equalTo(contentView)
            }
        }
        else {
            topGuideView.snp_makeConstraints { (make) in
                make.left.equalTo(contentView)
                make.top.equalTo(timestampImageView.snp_bottom)
                make.right.equalTo(contentView)
                make.height.equalTo(1)
                make.bottom.equalTo(contentView)
            }
        }
    }
    
    func photoImageViewTapped(sender: UITapGestureRecognizer) {
        delegate.articleDetailsTableViewCell(self, didTapPhotoImageView: sender.view as! UIImageView)
    }

}
