//
//  ArticleDetailsTableViewController.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/9/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class ArticleDetailsTableViewController: UITableViewController {
    
    var article: Article!
    var activityIndicatorView: ActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        if article.loaded == false {
            activityIndicatorView = ActivityIndicatorView(superview: tableView)
            activityIndicatorView.startAnimation()
            fetchArticle()
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.articleDetails, forIndexPath: indexPath)!
        cell.configure(article: article)

        return cell
    }
        
    
    // MARK: - Misc.
    
    @IBAction func shareButtonTapped(sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        alertController.addAction(UIAlertAction(
            title: "Open in Safari",
            style: .Default,
            handler: { (action) in
                UIApplication.sharedApplication().openURL(self.article.linkURL)                
            }
        ))
        
        alertController.addAction(UIAlertAction(
            title: "Share link",
            style: .Default,
            handler: { (action) in
                let activityVC = UIActivityViewController(
                    activityItems: [self.article.link],
                    applicationActivities: nil
                )
                
                if let popover = activityVC.popoverPresentationController {
                    popover.barButtonItem = sender
                }
                
                self.presentViewController(activityVC, animated: true, completion: nil)
            }
        ))
        
        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .Cancel,
            handler: nil
        ))
        
        if let popover = alertController.popoverPresentationController {
            popover.barButtonItem = sender
        }
        
        
        //popover.sourceView = view                
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func fetchArticle() {
        API(viewController: self)
            .request("articles/\(article.id)",
                     method: .GET,
                     parameters: nil,
                     completion: { (response: APIResponse) in
                        self.activityIndicatorView.stopAnimation()
                        self.article.combineWith(response.article!)
                        self.tableView.reloadData()
                    })
    }
    
    

}
