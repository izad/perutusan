//
//  AppDelegate.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var categories: [Category] = []

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window!.tintColor = kTintColor
        
        /*
 [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
 [UIFont fontWithName:kDefaultFont size:16.0f],UITextAttributeFont,
 nil] forState:UIControlStateNormal];
 */
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Futura-Medium", size: 16)!], forState: .Normal)
 
        return true
    }

}

