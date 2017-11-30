//
//  IssuesTableViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/19/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class IssuesTableViewController: UITableViewController {
    
    var collection: Collection?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = collection?.name
        
        let moveButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(IssuesTableViewController.toggleEdit))
            navigationItem.rightBarButtonItem = moveButton
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //this if let - else statement makes it possible to display a collection with 0 cells
        if let c = self.collection{
            return c.issues!.count
        }else {
            return 0
        }
    }
    
    //Controls cell transparency
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.75)
    }

    //Cell configuration
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issues", for: indexPath)
        let comicvine = (self.collection?.issues![indexPath.row])!
        if let d = comicvine.date {
            cell.textLabel?.text = comicvine.name! + " " + comicvine.issueNumber! + " : " + d
        } else {
            cell.textLabel?.text = comicvine.name! + " " + comicvine.issueNumber!
        }

        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        //tableView background picture
        let backgroundImage = UIImage(named: "comicbook_shelf.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //the Save bar button (for MainOld storyboard)
    /*@IBAction func saveButton(_ sender: Any) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        let savePath = documentsPath + "/collections.dat"
        print(savePath)
        NSKeyedArchiver.archiveRootObject(issues, toFile: savePath)
    }*/
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let c = self.collection {
                c.issues?.remove(at: indexPath.row)
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
                autoSave()
                print("autoSaved delete")
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @objc func toggleEdit(isEditing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        autoSave()
        print("autoSaved toggle")
    }
    
    func autoSave() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        let savePath = documentsPath + "/collections.dat"
        print(savePath)
        NSKeyedArchiver.archiveRootObject(collection?.issues, toFile: savePath)
    }

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let issuesMoving = collection?.issues?.remove(at: fromIndexPath.row)
        collection?.issues?.insert(issuesMoving!, at: to.row)
        autoSave()
        print("autoSaved rearranging")
    }
    
    //State Resoration, Keep commented out unless needed
    //----------------------------------------------
    /*
    override func encodeRestorableState(with coder: NSCoder) {
        if let collection = collection {
            coder.encode(collection, forKey: "collection")
        }
        super.encodeRestorableState(with: coder)
        print("encodeRestorableState")
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        collection = coder.decodeObject(forKey: "collection") as? Collection
        
        super.decodeRestorableState(with: coder)
        tableView.reloadData()
        print("decodeRestorableState")
    }
    
     override func applicationFinishedRestoringState() {
        guard let collection = collection else { return }
        self.collection = collection
        tableView.reloadData()
    }*/
    //----------------------------------------------
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchIssueSegue"){
            let destination = segue.destination as! SearchTableViewController
            destination.collection = collection
        }
        if (segue.identifier == "issueDetail"){
            let destination = segue.destination as! SearchDetailsViewController
            let indexPath = tableView.indexPathForSelectedRow
            let comicvine = self.collection?.issues![(indexPath?.row)!]
            destination.showCollectionsButton = false
            destination.comicvine = comicvine
        }
    }
    

}
