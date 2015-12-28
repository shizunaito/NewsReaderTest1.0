//
//  Yahoo.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/17.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import Alamofire

class Yahoo: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var newsDataArray = NSArray()
    var yahooUrl = ""
    var linktitle = ""
    
    @IBOutlet var table :UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        table.delegate = self
        
        let requestUrl = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://news.yahoo.co.jp/pickup/rss.xml&num=8"
        
        Alamofire.request(.GET,requestUrl).responseJSON { response in
            if let jsonDic = response.result.value as? NSDictionary {
                let responseData = jsonDic["responseData"] as! NSDictionary
                let feed = responseData["feed"] as! NSDictionary
                self.newsDataArray = feed["entries"] as! NSArray
                self.table.reloadData()
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return newsDataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell2 = tableView.dequeueReusableCellWithIdentifier("Cell2")! as UITableViewCell
        
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        
        let titleLabel2 = cell2.viewWithTag(1) as!  UILabel
        titleLabel2.text = newsDic["title"] as? String
        
        let dateLabel2 = cell2.viewWithTag(2) as! UILabel
        dateLabel2.text = newsDic["publishedDate"] as? String
        
/*        cell2.textLabel?.text = newsDic["title"] as! NSString as String
        cell2.textLabel?.numberOfLines = 3
        cell2.detailTextLabel?.text = newsDic["publishedDate"] as! NSString as String
*/
        return cell2
    }
    

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Get news data
        let newsDic = newsDataArray[indexPath.row] as! NSDictionary
        //Get news url
        yahooUrl = newsDic["link"] as! String
        linktitle = newsDic["title"] as! String
        //Move to WebViewController
        performSegueWithIdentifier("toYahooView", sender: self)
    }
    
    //Send URLData to WebViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let wvc = segue.destinationViewController as! YahooViewController
        wvc.newsUrl = yahooUrl
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
