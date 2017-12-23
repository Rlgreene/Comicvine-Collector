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
    @IBOutlet weak var saleDateLabel: UILabel!
    @IBOutlet weak var aRButton: UIButton!
    var comicvine: Comicvine?
    var collection: Collection?
    var newComic: Comicvine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = comicvine?.name
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        //Position activity indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        //if needed, you can prevent the activity indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        //Start activity indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        if let comicvine = self.comicvine {
            if let name = comicvine.name {
                self.nameLabel.text = name
            }
            
            if let issueNumber = comicvine.issueNumber {
                self.issueNumberLabel.text = issueNumber
            }
            
            if let saleDate = comicvine.saleDate {
                self.saleDateLabel.text = "Released on: \(saleDate)"
            } else {
                self.saleDateLabel.text = "Release date unavailable"
            }
            
            if let date = comicvine.date {
                self.dateLabel.text = "Cover date: \(date)"
            } else {
                self.dateLabel.text = "Cover date unavailable"
            }
            
            if let coverUrl = comicvine.coverUrl {
                //load the image data asynchronously
                DispatchQueue.main.async {
                let imageData = NSData(contentsOf: URL(string: coverUrl)!)
                if let imageDataUnwrapped = imageData {
                    comicvine.cover = imageDataUnwrapped as Data
                    
                }
                self.coverView.image = UIImage(data: comicvine.cover!)
                    
                //call stopAnimating() when need to stop activity indicator
                    myActivityIndicator.stopAnimating()
                
                //controls background (uses comicvine.cover)
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    //here is where i figure telling the app when to stop animating
        print("view will appear")
    }
    
    //Add button for MainOld
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "coverView") {
        let destination = segue.destination as! CoverViewController
        destination.comicvine = comicvine
    }
    if (segue.identifier == "addIssue"){
        let destination = segue.destination as! CollectionTableViewController
        destination.comicvine = comicvine
    }
    if (segue.identifier == "coverARView") {
        if #available(iOS 11.0, *) {
            let destination = segue.destination as! ARViewController
            destination.comicvine = comicvine
        } else {
            // Fallback on earlier versions
        }
    }
   }
    
}
