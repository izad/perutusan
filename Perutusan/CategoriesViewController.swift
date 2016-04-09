//
//  CategoriesViewController.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override var modalPresentationStyle: UIModalPresentationStyle {
        get { return .Custom }
        set {}
    }
    
    var filter: Filter!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!        
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewHeightConstraint.constant = 0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped(_:)))
        backgroundView.addGestureRecognizer(recognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.25, animations: {
            let height = CGFloat(appDelegate.categories.count) * 44
            
            if UIScreen.mainScreen().bounds.height > height + 64 {
                self.tableViewHeightConstraint.constant = height
            }
            else {
                self.tableViewHeightConstraint.constant = 44 * 6
            }
            
            self.view.layoutIfNeeded()
        })
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.category, forIndexPath: indexPath)!
        cell.configure(category: appDelegate.categories[indexPath.row])
        
        return cell
    }
    
    
    // MARK: - Table view delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        filter.category = appDelegate.categories[indexPath.row]
        close()
    }
    
    
    // MARK: - Misc.
    
    func backgroundViewTapped(sender: UITapGestureRecognizer) {
        close()
    }

    func close() {
        view.layoutIfNeeded()
        
        UIView.animateWithDuration(0.25, animations: {
            self.tableViewHeightConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.dismissViewControllerAnimated(false, completion: nil)
        }
    }
}
