//
//  TitleView.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class TitleView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!
    var delegate: TitleViewDelegate!
    var filter: Filter!
    
    func configure(filter filter: Filter, delegate: TitleViewDelegate) {
        nameLabel.text = filter.category.name.uppercaseString
        self.delegate = delegate
        
        self.filter = filter
        self.filter.addObserver(self, forKeyPath: "category", options: .New, context: nil)
    }        
    
    @IBAction func buttonTapped(sender: UIButton) {
        delegate.titleView(self, didTapButton: sender)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        nameLabel.text = filter.category.name.uppercaseString
    }
    
    deinit {
        filter.removeObserver(self, forKeyPath: "profilePhotoFullResolution")
    }
    
}
