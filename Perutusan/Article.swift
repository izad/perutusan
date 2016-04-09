//
//  Article.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import EVReflection

class Article: EVObject {
    
    var id: String!
    var link: String!
    var title: String!
    var photo: String?
    var timestamp: String!
    var subtitle: String?
    var author: String?
    var lead: String?
    var body: String?
    var caption: String?
    var color: UIColor!
    
    var loaded: Bool {
        get {
            return body != nil
        }
    }
    
    var linkURL: NSURL {
        get {
            return NSURL(string: link)!
        }
    }
    
    var photoURL: NSURL? {
        get {
            guard let photo = photo else {
                return nil
            }
            
            return NSURL(string: photo)
        }
    }
    
    func combineWith(article: Article) {
        self.subtitle = article.subtitle
        self.author = article.author
        self.lead = article.lead
        self.body = article.body
        self.caption = article.caption
    }
    
}