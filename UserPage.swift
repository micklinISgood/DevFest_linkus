//
//  UserPage.swift
//  linkus
//
//  Created by Mick Lin on 2/5/16.
//  Copyright © 2016 Mick Lin. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class UserPage: UIViewController {
    
    var pageIndex: Int!
    
    var titleText: String!
    
    var imageFile: String!
    let z_sign=["Aries", "Leo", "Sagittarius","Taurus", "Virgo", "Capricorn","Gemini","Libra", "Aquarius","Cancer", "Scorpio", "Pisces"]
    let univ = ["Brown University", "Columbia University", "Cornell University", "Dartmouth College", "Harvard University", "the University of Pennsylvania", "Princeton University", "Yale University"]
    
    let image = UIImage(named: "background.jpg")!
    let input = UIImage(named: "linkus.jpg")!
    
    @IBOutlet var mutual_fr: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
   
    @IBOutlet var logo: UIImageView!
    
    @IBOutlet var sign: UILabel!
    @IBOutlet var education: UILabel!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logo.image = resizeImage(input, newWidth: 200)
         //self.view.backgroundColor = UIColor(patternImage: resizeImage(image, newWidth: 610))
        
        print(pageIndex);
        
        self.titleLabel.text = randomStringWithLength(Int(arc4random_uniform(7))+3) as String
        self.sign.text = self.z_sign[Int(arc4random_uniform(12))]
        self.education.text = self.univ[Int(arc4random_uniform(8))]
        let dist = String((1+pageIndex*20+Int(arc4random_uniform(19))))
        self.mutual_fr.text = dist + " mile"
        let imageURL = String(format: "https://graph.facebook.com/\(imageFile)/picture?type=large")
        
        self.loadAndSetImage(imageURL)
        
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        
        blurView.frame = CGRectMake(0 ,0,(imageView.image?.size.width)!,150)
        imageView.addSubview(blurView)
        
      
        
        //self.token.text =  defaults.stringForKey("gender")
        
    }
    func randomStringWithLength (len : Int) -> NSString {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var randomString : NSMutableString = NSMutableString(capacity: len)
        
        for (var i=0; i < len; i++){
            var length = UInt32 (letters.length)
            var rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        
        return randomString
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
    func blur(view: UIImageView) {
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.alpha = 0.5
    blurEffectView.frame = view.bounds
    view.addSubview(blurEffectView)
    }
    func loadAndSetImage(url: String) {
        if let pictureURL = NSURL(string: url) {
            if let data = NSData(contentsOfURL: pictureURL) {
                //imageView.image = applyBlurEffect(UIImage(data: data)!)
                imageView.image = UIImage(data: data)
                //blur(imageView);
            }
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

}
