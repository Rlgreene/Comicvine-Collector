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
    
    init (issueNumber: String?, name: String?){
        self.issueNumber = issueNumber
        self.name = name
        
        
    }
    public convenience required init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let issueNumber = aDecoder.decodeObject(forKey: "issueNumber") as! String?
        let cover = aDecoder.decodeObject(forKey: "cover") as! Data
        let coverUrl = aDecoder.decodeObject(forKey: "coverUrl") as! String
        
        self.init(issueNumber: issueNumber, name: name)
        self.cover = cover
        self.coverUrl = coverUrl
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(issueNumber, forKey: "issueNumber")
        aCoder.encode(cover, forKey: "cover")
        aCoder.encode(coverUrl, forKey: "coverUrl")
    }
}
