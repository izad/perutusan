//
//  UIAlertControllerExtension.swift
//  Selklik Star
//
//  Created by Izad Che Muda on 2/3/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    class func showAlertWithTitle(title: String?, message: String?, inViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
