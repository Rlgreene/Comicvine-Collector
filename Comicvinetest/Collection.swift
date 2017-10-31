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
    var issues: [Comicvine]
    
    init(name: String?){
        self.name = name
        self.issues = [Comicvine]()
    }
    func addIssue(issue: Comicvine) -> Void {
        self.issues += [issue]
    
    }
}
