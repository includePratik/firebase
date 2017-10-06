//
//  Extension.swift
//  FireBallProject
//
//  Created by Chaitanya Pandit on 9/14/17.
//  Copyright © 2017 Chaitanya Pandit. All rights reserved.
//

import UIKit
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>()
var friendsphoto = UIImage()
extension UIImageView{
    
    func cacheImageUsingUrlString(url:String){

        
        if let cacheImage = ImageCache.sharedCache.object(forKey: url as AnyObject)  as? UIImage{
        self.image = cacheImage
            return
        }
        
        
      let tempURL = URL(string: url)
        let task = URLSession.shared.dataTask(with: tempURL!) { (data, response, error) in
            if  url.isEmpty == false{
                let myImage = FIRStorage.storage().reference(forURL: url)
                myImage.downloadURL(completion: { (newurl, err) in
                    if err != nil {
//                        print(err as Any)
                        return
                    }
                    
                    DispatchQueue.global().async {
                        if newurl != nil{
                            let data = NSData(contentsOf: newurl!)
                            if data != nil{
                            friendsphoto = UIImage(data: data! as Data)!
                            ImageCache.sharedCache.setObject(friendsphoto, forKey: url as AnyObject)
                                if let photo:UIImage = friendsphoto {
                            self.image = friendsphoto
                                }else{
                                    self.image = #imageLiteral(resourceName: "defaultProfileImage")
                                }
                            
                            }
                            }
                    }
                    
                    
                    
                })
            }
        }
        task.resume()
    
        
}
}

class ImageCache {
    
    static let sharedCache: NSCache = { () -> NSCache<AnyObject, AnyObject> in
        let cache = NSCache<AnyObject, AnyObject>()
        cache.name = "MyImageCache"
        cache.countLimit = 20 // Max 20 images in memory.
        cache.totalCostLimit = 10*1024*1024 // Max 10MB used.
        return cache
    }()
    
}

