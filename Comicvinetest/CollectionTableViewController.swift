//
//  CollectionTableViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/16/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController {
    var collections: [Collection] = []
    var initialLoad : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Collections"
        
        if !initialLoad{
          print("initial load")
        
        //Displays data that was saved from the previous session via the "saveCollections" UIButton action from the collections.dat folder
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        let collectionsPath = documentsPath + "/collections.dat"
        print(collectionsPath)
        
        if let collections = NSKeyedUnarchiver.unarchiveObject(withFile: collectionsPath) as? [Collection] {
            self.collections = collections
        }
            self.initialLoad = true
        }
        self.tableView.reloadData()
        print("view did load")
        
        let addButton = UIBarButtonItem (barButtonSystemItem: .add, target: self, action: #selector(CollectionTableViewController.addCollection))
        navigationItem.rightBarButtonItem = addButton
         

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

        return self.collections.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collections", for: indexPath)
        let collection = self.collections [indexPath.row]
        
        if let name = collection.name {
            cell.textLabel?.text = name
        } else {
            cell.textLabel?.text = "Please name collection"
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        self.tableView.reloadData()
        
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @objc func addCollection () {
        let newCollection = Collection(name: "New Collection")
        self.collections.append(newCollection)
        //let newIndexPath = IndexPath(row: self.collections.count - 1, section: 0)
        //self.tableView.insertRows(at: [newIndexPath], with: .automatic)
        self.tableView.reloadData()
    }
    
// the Save button that takes all new/existing data and stores it in the documents folder in the device's hardrive
    @IBAction func saveCollections(_ sender: Any) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        let collectionsPath = documentsPath + "/collections.dat"
        print(collectionsPath)
        NSKeyedArchiver.archiveRootObject(collections, toFile: collectionsPath)
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.collections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

   
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "collectionNameSegue") {
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        let collection = self.collections[indexPath.row]
        let destination = segue.destination as! CollectionNamingViewController
        destination.collection = collection
        }
        if (segue.identifier == "issuesSegue"){
            let destination = segue.destination as! IssuesTableViewController
            let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
            let collection = self.collections[indexPath.row]
            destination.collection = collection
        }
    }
    

}
