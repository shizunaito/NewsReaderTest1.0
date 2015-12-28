//
//  YahooViewController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/17.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import Social

class YahooViewController: UIViewController,UIWebViewDelegate {
    
    @IBOutlet var Yahooview :UIWebView! = UIWebView()
    
    var newsUrl = ""
    var linktitle = ""
    var indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //where UIWebViewDelegate
        Yahooview.delegate = self
        //centering indicator
        indicator.center = self.view.center
        //indicator color set gray
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        //set indicator in webview
        Yahooview.addSubview(indicator)
        //Transeform newsUrl to NSURL
        let url = NSURL(string: newsUrl)!
        //Send URLInformation to NSURLRequest
        let urlRequest = NSURLRequest(URL: url)
        //Do load method of UIWebView class
        Yahooview.loadRequest(urlRequest)

        // Do any additional setup after loading the view.
    }

    @IBAction func Twitter(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            let controller = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            let url = NSURL(string: newsUrl)!
            controller.addURL(url)
            controller.setInitialText(linktitle)
            
            presentViewController(controller, animated: true, completion: {})
        }
    }
    
    
    @IBAction func Facebook(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            let url = NSURL(string: newsUrl)!
            controller.addURL(url)
            controller.setInitialText(linktitle)
            
            presentViewController(controller, animated: true, completion: {})
        }
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
