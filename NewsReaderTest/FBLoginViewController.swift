//
//  FBLoginViewController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/21.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FBLoginViewController: UIViewController{
    
    var userProfile : NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnFBLoginPressed(sender: AnyObject) {
        
        let fb: FBSDKLoginManager = FBSDKLoginManager()
        fb.logInWithReadPermissions(["email"], fromViewController: self, handler: {(result : FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
            if ((error) != nil) {
                // エラー
                print("error")
            } else if result.isCancelled {
                // キャンセル
                print("cancel")
                if (FBSDKAccessToken.currentAccessToken() == nil)
                {
                    print("Not logged in..")
                }
                else
                {
                    print("Logged in..")
                }
                
            } else {
                let token = FBSDKAccessToken.currentAccessToken()
                if token != nil {
                    // ユーザーIDが取得できる
                    print("ok")
                    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"])
                    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        if ((error) == nil) {
                            
                            // プロフィール情報をディクショナリに入れる
                            self.userProfile = result as! NSDictionary
                            print(self.userProfile!)
                            
                            let profileImageURL : String = self.userProfile.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String

                            // インスタンス生成
                            let defaults = NSUserDefaults.standardUserDefaults()
                            
                            // キーに値をそれぞれ保存
                            defaults.setObject(self.userProfile.objectForKey("name"), forKey:"Name")
                            defaults.setObject(self.userProfile.objectForKey("email"), forKey:"Email")
                            defaults.setObject(self.userProfile.objectForKey("gender"), forKey:"Gender")
                            defaults.setObject(profileImageURL, forKey: "Url")
                            defaults.synchronize()
                            
                            let test = defaults.stringForKey("Name")
                            print(test)
                            
                        }
                    })
                }
            }
        })

    }
    
    //ログアウトボタンが押された時の処理
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil {
            print("User Already Logged In")
            self.performSegueWithIdentifier("ShowMain", sender: self)
        } else {
            print("User not Logged In")
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    func returnUserData()
    {
    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me",
    parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, gender"])
    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
    if ((error) != nil)
    {
    // エラー処理
    print("Error: \(error)")
    }
    else
    {
    // プロフィール情報をディクショナリに入れる
    self.userProfile = result as! NSDictionary
    print(self.userProfile)
    
    // プロフィール画像の取得（よくあるように角を丸くする）
    let profileImageURL : String = self.userProfile.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String
    let profileImage = UIImage(data: NSData(contentsOfURL: NSURL(string: profileImageURL)!)!)
    self.usrImage.clipsToBounds = true
    self.usrImage.layer.cornerRadius = 60
    self.usrImage.image = self.trimPicture(profileImage!)
    
    //名前とemail
    
    self.usrName.text = self.userProfile.objectForKey("name") as? String
    self.usrGender.text = self.userProfile.objectForKey("gender") as? String
    self.usrEmail.text = self.userProfile.objectForKey("email") as? String
    
    }
    })
    
    }
    func trimPicture(rawPic:UIImage) -> UIImage {
    let rawImageW = rawPic.size.width
    let rawImageH = rawPic.size.height
    
    let posX = (rawImageW - 200) / 2
    let posY = (rawImageH - 200) / 2
    let trimArea : CGRect = CGRectMake(posX, posY, 200, 200)
    
    let rawImageRef:CGImageRef = rawPic.CGImage!
    let trimmedImageRef = CGImageCreateWithImageInRect(rawImageRef, trimArea)
    let trimmedImage : UIImage = UIImage(CGImage : trimmedImageRef!)
    return trimmedImage
    }
    
    */

}
