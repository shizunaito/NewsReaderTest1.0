//
//  PageViewController.swift
//  NewsReaderTest
//
//  Created by 伊藤静那(Ito Shizuna) on 2015/12/27.
//  Copyright © 2015年 ShizunaIto. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var myViewControllers : [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.delegate = self
        self.dataSource = self
        
        let p1 = storyboard?.instantiateViewControllerWithIdentifier("FacebookLogin") as! FBLoginViewController
        let p2 = storyboard?.instantiateViewControllerWithIdentifier("TwitterLogin") as! TwitterLoginViewController
        
        myViewControllers = [p1,p2]
        
        let startingViewController = self.viewControllerAtIndex(0)
        let viewControllers: NSArray = [startingViewController]
        
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: {(done: Bool) in
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Private Function
    func viewControllerAtIndex (index: NSInteger) -> UIViewController{
        return myViewControllers[index]
    }
    
    //Delegates and Datasource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = myViewControllers.indexOf(viewController)!
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        index--
        if index == myViewControllers.count {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = myViewControllers.indexOf(viewController)!
      
        if index == NSNotFound {
            return nil
        }
        index++
        if index == myViewControllers.count {
            return nil
        }
      
        return self.viewControllerAtIndex(index)
        
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return myViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    
    
}
