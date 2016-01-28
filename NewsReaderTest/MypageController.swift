//
//  MypageController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/21.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class MypageController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var userProfile : NSDictionary!

    @IBOutlet weak var MypageTable: UITableView!
    @IBOutlet weak var usrImage: UIImageView!
    
    let titles = ["名前", "性別", "メール"]
    var details = ["...","...","..."]
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MypageTable.dataSource = self
        MypageTable.delegate = self
        defaults.synchronize()
        if((defaults.objectForKey("Name")) != nil){
            
            let profileImageURL = defaults.objectForKey("Url") as! String
            let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: profileImageURL)!)!)
        
            self.usrImage.clipsToBounds = true
            self.usrImage.layer.cornerRadius = 60
            self.usrImage.image = profileImage!

            details[0] = defaults.objectForKey("Name") as! String
            details[1] = defaults.objectForKey("Gender") as! String
            details[2] = defaults.objectForKey("Email") as! String
            defaults.synchronize()
        }
        else {print("nil")}

        // Do any additional setup after loading the view.
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = details[indexPath.row]
                
        return cell
    }

    
    @IBAction func logout(sender: AnyObject) {
        let alert:UIAlertController = UIAlertController(title:"ログアウトしますか",
            message: "",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "いいえ",
            style: UIAlertActionStyle.Cancel,
            handler:{
                (action:UIAlertAction!) -> Void in
                print("Cancel")
        })
        
        let defaultAction:UIAlertAction = UIAlertAction(title: "はい",
            style: UIAlertActionStyle.Default,
            handler:{
                (action:UIAlertAction!) -> Void in
                
                let loginManager : FBSDKLoginManager = FBSDKLoginManager()
                loginManager.logOut()
                self.defaults.removeObjectForKey("Name")
                self.defaults.removeObjectForKey("Gender")
                self.defaults.removeObjectForKey("Email")
                self.defaults.removeObjectForKey("Url")
                self.dismissViewControllerAnimated(true, completion: nil)
                
        })

         alert.addAction(cancelAction)
         alert.addAction(defaultAction)
        
        presentViewController(alert, animated: true, completion: nil)
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
