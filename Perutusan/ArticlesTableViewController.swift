//
//  ArticlesTableViewController.swift
//  Perutusan
//
//  Created by Izad Che Muda on 4/8/16.
//  Copyright © 2016 Izad Che Muda. All rights reserved.
//

import UIKit

class ArticlesTableViewController: UITableViewController, TitleViewDelegate {
    
    var articles: [Article] = []
    var titleView: TitleView!
    var filter: Filter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filter = Filter()
        filter.category = appDelegate.categories.first!
        filter.addObserver(self, forKeyPath: "category", options: .New, context: nil)
        title = filter.category.name.uppercaseString
        
        titleView = NSBundle.mainBundle().loadNibNamed("TitleView", owner: self, options: nil).first as! TitleView
        titleView.configure(filter: filter, delegate: self)
        navigationItem.titleView = titleView

        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(fetchArticles), forControlEvents: .ValueChanged)
        
        tableView.tableFooterView = UIView()
        tableView.addSubview(refreshControl!)        
        
        prepareToFetchArticles()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        title = filter.category.name.uppercaseString
        prepareToFetchArticles()
    }
    
    deinit {
        filter.removeObserver(self, forKeyPath: "profilePhotoFullResolution")
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
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (UIScreen.mainScreen().bounds.height - 64) / 3
    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(R.segue.articlesTableViewController.showArticleDetails, sender: indexPath)
    }
    
    
    // MARK: - Title view delegate
    
    func titleView(titleView: TitleView, didTapButton button: UIButton) {
        performSegueWithIdentifier(R.segue.articlesTableViewController.showCategories.identifier, sender: nil)
    }
    
    
    // MARK: - Misc.
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
            case R.segue.articlesTableViewController.showCategories.identifier:
                let categoriesVC = segue.destinationViewController as! CategoriesViewController
                categoriesVC.filter = filter
            
            case R.segue.articlesTableViewController.showArticleDetails.identifier:
                let indexPath = sender as! NSIndexPath
                let articleDetailsTVC = segue.destinationViewController as! ArticleDetailsTableViewController
                articleDetailsTVC.article = articles[indexPath.row]
            
            default:
                break
        }
    }
    
    func prepareToFetchArticles() {        
        tableView.showRefreshControl(refreshControl!)        
        fetchArticles()
    }
    
    func fetchArticles() {
        API(viewController: self)
            .request("categories\(filter.category.path)",
                     method: .GET,
                     parameters: nil) { (response: APIResponse) in
                        self.articles = response.articles
                        
                        for article in self.articles {
                            article.color = UIColor.randomColor()
                        }
                        
                        self.tableView.reloadData()
                        self.refreshControl!.endRefreshing()
                     }
    }

}
