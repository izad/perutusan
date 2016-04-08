//
//  ArticlesTableViewController.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController {
    
    var articles: [Article] = []
    var titleView: TitleView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView = NSBundle.mainBundle().loadNibNamed("TitleView", owner: self, options: nil).first as! TitleView
        navigationItem.titleView = titleView

        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(fetchArticles), forControlEvents: .ValueChanged)
        
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl!)        
        
        refreshControl!.beginRefreshing()
        tableView.setContentOffset(CGPointMake(0, -refreshControl!.frame.size.height), animated: true)
        fetchArticles()
    }

  
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(R.reuseIdentifier.article, forIndexPath: indexPath)!
        cell.configure(article: articles[indexPath.row])
        
        // [[UIDevice currentDevice] orientation]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var navBarHeight = navigationController!.navigationBar.frame.size.height
        
        if UIApplication.sharedApplication().statusBarHidden == false {
            navBarHeight += 20
        }
        
        return (UIScreen.mainScreen().bounds.height - navBarHeight) / 3
    }
    
    
    // MARK: - Misc.
    
    func fetchArticles() {
        API(viewController: self)
            .request("categories\(appDelegate.categories.first!.path)",
                     method: .GET,
                     parameters: nil) { (response: APIResponse) in
                        self.articles = response.articles
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
                     }
    }

}
