//
//  Collection.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/17/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class Collection: NSObject {
    var name: String?
    var issues: [(String, String)]
    
    init(name: String?){
        self.name = name
        self.issues = [(String, String)]()
    }
    func addIssue(issueNumber: String, name: String) -> Void {
        self.issues += [(issueNumber, name)]
    
    }
}
