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
    @IBOutlet weak var dateLabel: UILabel!
    var comicvine: Comicvine?
    var collection: Collection?
    var showCollectionsButton: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let backgroundImage = UIImage(named: "wood_shelves.jpg")
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        self.view.insertSubview(backgroundImageView, at: 0)*/
        
        if let comicvine = self.comicvine {
            if let name = comicvine.name {
                self.nameLabel.text = name
            }
            
            if let issueNumber = comicvine.issueNumber {
                self.issueNumberLabel.text = issueNumber
            }
            
            if let date = comicvine.date {
                self.dateLabel.text = "Print released on \(date)"
            } else {
                self.dateLabel.text = "Release date unavailable"
            }
            
            if let coverUrl = comicvine.coverUrl {
                let imageData = NSData(contentsOf: URL(string: coverUrl)!)
                if let imageDataUnwrapped = imageData {
                    comicvine.cover = imageDataUnwrapped as Data
                    
                }
                self.coverView.image = UIImage(data: comicvine.cover!)
                
                //controls background (uses cover art)
                let backgroundImage = UIImage(data: comicvine.cover!)
                let backgroundImageView = UIImageView(frame: self.view.frame)
                backgroundImageView.image = backgroundImage
                backgroundImageView.contentMode = .scaleAspectFill
                self.view.insertSubview(backgroundImageView, at: 0)
                
                if #available(iOS 10.0, *) {
                    let blurEffect = UIBlurEffect(style: .regular)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = self.view.frame
                    self.view.insertSubview(blurView, at: 1)
                } else {
                    // Fallback on earlier versions
                    let blurEffect = UIBlurEffect(style: .light)
                    let blurView = UIVisualEffectView(effect: blurEffect)
                    blurView.frame = self.view.frame
                    self.view.insertSubview(blurView, at: 1)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Add button for MainOld
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
