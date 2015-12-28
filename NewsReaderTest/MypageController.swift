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
    
    @IBOutlet weak var usrImage: UIImageView!

    var userProfile : NSDictionary!
    

    @IBOutlet weak var MypageTable: UITableView!
    
    let titles = ["名前", "性別", "メール"]
//    let tests = ["...","...","..."]

    var user: [String] = []
    //NSUserDefaultsのインスタンスを生成
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MypageTable.dataSource = self
        MypageTable.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //前回の保存内容があるかどうかを判定
        if((defaults.objectForKey("USER")) != nil){
            
            //objectsを配列として確定させ、前回の保存内容を格納
//            let objects = defaults.objectForKey("USER") as! NSArray
            
        }

        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.textLabel?.text = titles[indexPath.row]
//        cell.detailTextLabel?.text = objects[indexPath.row]
        
                
        return cell
    }

    
    @IBAction func logout(sender: AnyObject) {
        let loginManager : FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        self.dismissViewControllerAnimated(true, completion: nil)
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
