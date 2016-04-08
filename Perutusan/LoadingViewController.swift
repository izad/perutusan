//
//  LoadingViewController.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        API(viewController: self).request("/categories",
                                          method: .GET,
                                          parameters: nil) { (response: APIResponse) in
                                            appDelegate.categories = response.categories
                                            self.performSegueWithIdentifier(R.segue.loadingViewController.showArticles, sender: nil)
                                          }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
