//
//  UIViewExtension.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/9/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var previousSubview: UIView {
        get {
            return self.subviews[self.subviews.count - 2]
        }
    }
    
}