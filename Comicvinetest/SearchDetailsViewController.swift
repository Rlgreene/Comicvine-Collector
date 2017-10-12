//
//  SearchDetailsViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/10/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class SearchDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueNumberLabel: UILabel!
    @IBOutlet weak var coverView: UIImageView!
    var comicvine: Comicvine?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let comicvine = self.comicvine {
            if let name = comicvine.name {
                self.nameLabel.text = name
            }
            if let issueNumber = comicvine.issueNumber {
                self.issueNumberLabel.text = issueNumber
            }
            if let cover = comicvine.cover {
                self.coverView.image = cover
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    //}
    

}
