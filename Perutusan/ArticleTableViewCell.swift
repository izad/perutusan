//
//  ArticleTableViewCell.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    func configure(article article: Article) {
        backgroundColor = article.color
        titleLabel.text = article.title
        timestampLabel.text = article.timestamp.uppercaseString
        photoImageView.image = nil
        
        if let photoURL = article.photoURL {
            photoImageView.af_setImageWithURL(photoURL)
        }
    }

}
