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
    var collection: Collection?
    var showCollectionsButton: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let comicvine = self.comicvine {
            if let name = comicvine.name {
                self.nameLabel.text = name
            }
            
            if let issueNumber = comicvine.issueNumber {
                self.issueNumberLabel.text = issueNumber
            }
            
            if let coverUrl = comicvine.coverUrl {
                let imageData = NSData(contentsOf: URL(string: coverUrl)!)
                if let imageDataUnwrapped = imageData {
                    comicvine.cover = imageDataUnwrapped as Data
                    
                }
                self.coverView.image = UIImage(data: comicvine.cover!)
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "addIssuesSegue") {
        collection?.addIssue(issue: comicvine!)
        let destination = segue.destination as! IssuesTableViewController
        destination.collection = collection
    }
   }
    
}
