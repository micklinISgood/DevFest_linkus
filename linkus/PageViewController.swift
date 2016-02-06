//
//  PageViewController.swift
//  linkus
//
//  Created by Mick Lin on 2/6/16.
//  Copyright © 2016 Mick Lin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class PageViewController: UIViewController,UIPageViewControllerDataSource {
    var pageViewController: UIPageViewController!
    let image = UIImage(named: "background.jpg")!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var pageTitles:[String] = []
    
    var pageImages:[String] = []
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: resizeImage(image, newWidth: 610))
        
        let fr = defaults.dictionaryForKey("friends") as! NSDictionary
        
        if let friendObjects = fr["data"] as? [NSDictionary] {
            for friendObject in friendObjects {
                print(friendObject["id"] as! NSString)
                self.pageImages.append(friendObject["id"] as! String)
                print(friendObject["name"] as! NSString)
                self.pageTitles.append(friendObject["name"] as! String)

            }
        }

        
        
        //self.pageTitles = NSArray(objects: "Explore", "Today Widget")
        
        //self.pageImages = NSArray(objects: "tea.jpg", "paper.jpg")
        
       
       
        
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        
        self.pageViewController.dataSource = self
        self.view.backgroundColor = UIColor.blackColor()
        
        var startVC = self.viewControllerAtIndex(0) as UserPage
        
        var viewControllers = NSArray(object: startVC)
        
        
        
        self.pageViewController.setViewControllers(viewControllers as! [UIViewController], direction: .Forward, animated: true, completion: nil)
        
        
        
        self.pageViewController.view.frame = CGRectMake(0, 30, self.view.frame.width, self.view.frame.size.height - 60)
        
        
        
        self.addChildViewController(self.pageViewController)
        
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMoveToParentViewController(self)
        


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
  
    func viewControllerAtIndex(index: Int) -> UserPage
        
    {
        
        if ((self.pageTitles.count == 0) || (index >= self.pageTitles.count)) {
            
            return UserPage()
            
        }
        
        
        
        var vc: UserPage = self.storyboard?.instantiateViewControllerWithIdentifier("UserPage") as! UserPage
        
        
        
        vc.imageFile = self.pageImages[index] as! String
        
        vc.titleText = self.pageTitles[index] as! String
        
        vc.pageIndex = index
        
        
        
        return vc
        
        
        
        
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
        
    {
        
        
        
        var vc = viewController as! UserPage
        
        var index = vc.pageIndex as Int
        
        
        
        
        
        if (index == 0 || index == NSNotFound)
            
        {
            
            return nil
            
            
            
        }
        
        
        
        index--
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        
        
        var vc = viewController as! UserPage
        
        var index = vc.pageIndex as Int
        
        
        
        if (index == NSNotFound)
            
        {
            
            return nil
            
        }
        
        
        
        index++
        
        
        
        if (index == self.pageTitles.count)
            
        {
            
            return nil
            
        }
        
        
        
        return self.viewControllerAtIndex(index)
        
        
        
    }
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return self.pageTitles.count
        
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
        
    {
        
        return 0
        
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
