//
//  Extensions.swift
//  Comicvinetest
//
//  Created by Richard Greene on 12/16/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import Foundation


extension UIImageView {
    
    func downloadImageUrl(urlString: String, defaultThumbnail: String?) {
        if let dt = defaultThumbnail {
            self.image = UIImage(named: dt)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
                print("downloaded image")
            })
        }).resume()
    }
}

