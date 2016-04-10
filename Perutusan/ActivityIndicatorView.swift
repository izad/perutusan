//
//  ActivityIndicatorView.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/10/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class ActivityIndicatorView: NVActivityIndicatorView {
    
    init(superview: UIView) {
        let dimension: CGFloat = 50
        super.init(frame: CGRectMake(0, 0, dimension, dimension), type: .BallScaleMultiple, color: kTintColor, padding: 0)
        
        let bounds = UIScreen.mainScreen().bounds
        center = CGPointMake(bounds.width / 2, bounds.height / 2 - dimension)
        superview.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}