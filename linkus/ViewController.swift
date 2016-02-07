//
//  ViewController.swift
//  linkus
//
//  Created by Mick Lin on 2/5/16.
//  Copyright © 2016 Mick Lin. All rights reserved.
//

import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    let defaults = NSUserDefaults.standardUserDefaults()
    let image = UIImage(named: "background.jpg")!
    let input = UIImage(named: "linkus.jpg")!

    @IBOutlet var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = resizeImage(input, newWidth: 200)
       
        
        
        self.view.backgroundColor = UIColor(patternImage: resizeImage(image, newWidth: 610))
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("Logged in..")
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile","user_education_history","email","user_birthday","user_work_history","user_friends"]
        loginButton.center = CGPointMake(self.view.frame.size.width/2 , self.view.frame.size.height-120);
        loginButton.delegate = self
        self.view.addSubview(loginButton)
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
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            
            print("Login complete.")
            
            //NSLog("result is:%@",result.token);
            if(FBSDKAccessToken.currentAccessToken() != nil) {
                //They are logged in so show another view
               
                returnUserData()
                
                
                NSLog("result is:%@","hey");
            } else {
                //They need to log in
            }
            
            //let defaults = NSUserDefaults.standardUserDefaults()
            //defaults.setObject(result.token, forKey: "fb_token")
            let pageControl = UIPageControl.appearance()
            
            pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
            
            pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
            
            pageControl.backgroundColor = UIColor.blackColor()
            
           self.performSegueWithIdentifier("showNew", sender: self)
            
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath:  "me", parameters: ["fields": "id,name,gender,email,friends,education,work"+FBSDKAccessToken.currentAccessToken().tokenString])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
                
            {
                let fbid = result.valueForKey("id") as! String
                let name = result.valueForKey("name") as? String
                let gender = result.valueForKey("gender") as? String
                let email = result.valueForKey("email") as? String
                
                
                let fr = result.valueForKey("friends") as! NSDictionary
                if let friendObjects = fr["data"] as? [NSDictionary] {
                    for friendObject in friendObjects {
                        print(friendObject["id"] as! NSString)
                        print(friendObject["name"] as! NSString)
                    }
                }
                
                
                self.defaults.setObject(fr , forKey: "friends")
                self.defaults.setObject(fbid , forKey: "id")
                self.defaults.setObject(name, forKey: "name")
                self.defaults.setObject(gender, forKey: "gender")
                self.defaults.setObject(email, forKey: "email")
                
                
            }
        })
    }


    


}

