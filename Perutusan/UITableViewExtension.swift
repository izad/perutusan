//
//  UITableViewExtension.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/9/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation

extension UITableView {
    
    func showRefreshControl(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        setContentOffset(CGPointMake(0, -refreshControl.frame.size.height), animated: true)
    }
    
}