//
//  CoverViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 12/6/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class CoverViewController: UIViewController {
    
    @IBOutlet weak var coverView: UIImageView!
    var comicvine: Comicvine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = (comicvine?.name)! + " " + (comicvine?.issueNumber)!
        
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = true
        view.addSubview(myActivityIndicator)
        
        myActivityIndicator.startAnimating()
        
        if let comicvine = self.comicvine {
            DispatchQueue.main.async {
            if let coverUrl = comicvine.coverUrl{
                let imageData = NSData(contentsOf: URL(string: coverUrl)!)
                if let imageDataUnwrapped = imageData {
                    comicvine.cover = imageDataUnwrapped as Data
                }
                self.coverView.image = UIImage(data: comicvine.cover!)
                myActivityIndicator.stopAnimating()
                }
            }
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
