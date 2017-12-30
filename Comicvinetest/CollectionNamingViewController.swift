//
//  CollectionNamingViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/17/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class CollectionNamingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    var collection: Collection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Edit Shelf Name"
        
        let backgroundImage = UIImage(named: "background4Longbox.jpg")
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.nameField.delegate = self
        
        if let collection = self.collection {
            if let name = collection.name {
                self.nameField.text = name
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.nameField {
            self.collection?.name = textField.text
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameField.resignFirstResponder()
        return(true)
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
