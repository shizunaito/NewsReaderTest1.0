//
//  Google.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/17.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import Alamofire

class Google: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newsDataArray = NSArray()
    var GoogleUrl = ""
    var linktitle = ""
    var refreshControl:UIRefreshControl!

    @IBOutlet var table1 :UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table1.dataSource = self
        table1.delegate = self
        let requestUrl = "http://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"
        
        Alamofire.request(.GET,requestUrl).responseJSON { response in
            if let jsonDic = response.result.value as? NSDictionary {
                let responseData = jsonDic["responseData"] as! NSDictionary
                self.newsDataArray = responseData["results"] as! NSArray
                 self.table1.reloadData()
            }
        }

        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "refresh...")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents:.ValueChanged)
        self.refreshControl.center.y = self.view.center.y
        self.table1.addSubview(self.refreshControl)

         
    }
    
        func refresh(refreshControl: UIRefreshControl)
    {
        let requestUrl = "http://ajax.googleapis.com/ajax/services/search/news?v=1.0&topic=p&hl=ja&rsz=8"
        
        Alamofire.request(.GET,requestUrl).responseJSON { response in
            if let jsonDic = response.result.value as? NSDictionary {
                let responseData = jsonDic["responseData"] as! NSDictionary
                self.newsDataArray = responseData["results"] as! NSArray
               
            }
        // 更新するコード(webView.reload()など)
        self.refreshControl.endRefreshing()
        self.table1.reloadData()
        }
    
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return newsDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell1 = tableView.dequeueReusableCellWithIdentifier("Cell1")! as UITableViewCell
        
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        
        let titleLabel1 = cell1.viewWithTag(1) as!  UILabel
        titleLabel1.text = newsDic["title"] as? String
        
        let dateLabel1 = cell1.viewWithTag(2) as! UILabel
        dateLabel1.text = newsDic["publishedDate"] as? String
        
        return cell1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Get news data
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        //Get news url
        GoogleUrl = newsDic["unescapedUrl"] as! String
        linktitle = newsDic["title"] as! String
        //Move to WebViewController
        performSegueWithIdentifier("toGoogleView", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wvc = segue.destinationViewController as! GoogleViewController
        wvc.newsUrl = GoogleUrl
        wvc.linktitle = linktitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
