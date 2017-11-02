//
//  Collection.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/17/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class Collection: NSObject, NSCoding {
    var name: String?
    var issues: [Comicvine]?
    
    init(name: String?){
        self.name = name
        self.issues = [Comicvine]()
    }
    func addIssue(issue: Comicvine) -> Void {
        self.issues?.append(issue)
    
    }
    //NSCoding
    public convenience required init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let issues = aDecoder.decodeObject(forKey: "issues") as! [Comicvine]
        
        self.init(name:name)
            for issue in issues{
                self.addIssue(issue: issue)
            }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(issues, forKey: "issues")
    }
   // NSKeyedArchiver.archiveRootObject(collections, toFile: "/path/to/archive")
    
   // let data = NSKeyedArchiver.archivedData(withRootObject: collections)
   // NSUserDefaults.standardUserDefaults().setObject(data, forKey: "collections")
}
