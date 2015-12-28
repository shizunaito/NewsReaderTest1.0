//
//  ViewController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/14.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit
import PagingMenuController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //1ページ目で表示させるコントローラーを指定する
        let page_1 = self.storyboard?.instantiateViewControllerWithIdentifier("Google") as! Google
        page_1.title = "Google"
        
        //2ページ目で表示させるコントローラーを指定する
        let page_2 = self.storyboard?.instantiateViewControllerWithIdentifier("Yahoo") as! Yahoo
        page_2.title = "Yahoo"
 
        let viewControllers = [page_1, page_2]
        
        
        //表示オプション
        let options = PagingMenuOptions()   //オプションをインスタンス化
        
        //最初に表示させるページ番号
        options.defaultPage = 0
        
        //スワイプでページ間を移動させるか
        options.scrollEnabled = true
        
        //メニューバーの背景色
        options.backgroundColor = UIColor.whiteColor()
        
        //選択中のメニューバーの背景色
        options.selectedBackgroundColor = UIColor.whiteColor()
        
        //メニューのフォントサイズ
        options.font = UIFont.systemFontOfSize(14)
        
        //選択中のメニューのフォントサイズ
        options.selectedFont = UIFont.systemFontOfSize(14)
        
        //メニューの位置
        options.menuPosition = .Top
        
        //メニューの高さ
        options.menuHeight = 44
        
        //メニューのマージン
        options.menuItemMargin = 8
        
        //ページ移動をするときのアニメーションスピード
        options.animationDuration = 0.3
        
        //選択中のメニューの下線の色
        options.menuItemMode = .Underline(height: 3, color: UIColor.blackColor(), horizontalPadding: 0, verticalPadding: 0)
        
        //メニューの表示のされ方
        options.menuDisplayMode = .SegmentedControl
        
        
        let pagingMenuController = PagingMenuController(viewControllers: viewControllers, options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        
        self.addChildViewController(pagingMenuController)
        self.view.addSubview(pagingMenuController.view)
        pagingMenuController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

