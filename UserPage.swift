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
        
        self.titleLabel.text = self.titleText
        self.sign.text = self.z_sign[Int(arc4random_uniform(12))]
        self.education.text = self.univ[Int(arc4random_uniform(8))]
        var dist = String((1+pageIndex*20+Int(arc4random_uniform(19))))
        self.mutual_fr.text = dist + " mile"
        let imageURL = String(format: "https://graph.facebook.com/\(imageFile)/picture?type=large")
        self.loadAndSetImage(imageURL)
        //self.imageView.image = UIImage(named: self.imageFile)
        
        //self.token.text =  defaults.stringForKey("gender")
        
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
    func loadAndSetImage(url: String) {
        if let pictureURL = NSURL(string: url) {
            if let data = NSData(contentsOfURL: pictureURL) {
                imageView.image = UIImage(data: data)
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
