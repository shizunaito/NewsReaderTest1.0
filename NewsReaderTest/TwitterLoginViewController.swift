//
//  TwitterLoginViewController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/27.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterLoginViewController: UIViewController {

    override func viewDidLoad() {

        // Do any additional setup after loading the view.
    }

    @IBAction func TwitterLogin(sender: AnyObject) {
        
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            if (session != nil) {
                print("signed in user name \(session!.userName)")
                self.performSegueWithIdentifier("showMain2", sender: self)
            } else {
                print("Error：\(error!.localizedDescription)")
    }
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
