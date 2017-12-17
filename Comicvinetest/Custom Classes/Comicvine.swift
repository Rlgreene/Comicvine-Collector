//
//  Comicvine.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/5/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class Comicvine: NSObject, NSCoding {
    var issueNumber: String?
    var name: String?
    var cover: Data?
    var coverUrl: String?
    var date: String?
    var saleDate: String?
    var thumbnail: Data?
    var iconUrl: String?
    
    init (issueNumber: String?, name: String?, date: String?, saleDate: String?){
        self.issueNumber = issueNumber
        self.name = name
        self.date = date
        self.saleDate = saleDate
    }
    
    //This class also needs NSCoding as it is a class featured in the 'Collection' class
    public convenience required init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let issueNumber = aDecoder.decodeObject(forKey: "issueNumber") as! String?
        let cover = aDecoder.decodeObject(forKey: "cover") as! Data?
        let coverUrl = aDecoder.decodeObject(forKey: "coverUrl") as! String
        let date = aDecoder.decodeObject(forKey: "date") as! String?
        let saleDate = aDecoder.decodeObject(forKey: "saleDate") as! String?
        let thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as! Data?
        let iconUrl = aDecoder.decodeObject(forKey:"iconUrl") as! String?
        
    //initializer being used when saving/displaying cell textLabels in 'IssuesTableViewController'
        self.init(issueNumber: issueNumber, name: name, date: date, saleDate: saleDate)
        self.cover = cover
        self.coverUrl = coverUrl
        self.thumbnail = thumbnail
        self.iconUrl = iconUrl
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(issueNumber, forKey: "issueNumber")
        aCoder.encode(cover, forKey: "cover")
        aCoder.encode(coverUrl, forKey: "coverUrl")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(saleDate, forKey: "saleDate")
        aCoder.encode(thumbnail, forKey: "thumbnail")
        aCoder.encode(iconUrl, forKey: "iconUrl")
    }
}
