//
//  Comicvine.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/5/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class Comicvine: NSObject {
    var issueNumber: String?
    var name: String?
    var cover: Data?
    var coverUrl: String?
    
    init (issueNumber: String?, name: String?){
        self.issueNumber = issueNumber
        self.name = name
        
        
    }
    
}
