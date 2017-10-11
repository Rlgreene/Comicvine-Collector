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
    var cover: String?
    
    init (issueNumber: String? = nil, name: String? = nil){
        self.issueNumber = issueNumber
        self.name = name
    }
    init?(cover: CGImage) {
        self.cover = cover
    }
    
}
