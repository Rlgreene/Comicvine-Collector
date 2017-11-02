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
    
    var issues: [Comicvine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    //this if let - else statement makes it possible to start a new collection with 0 cells
        if let c = self.collection{
            return c.issues!.count
        }else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issue", for: indexPath)
        let comicvine = (self.collection?.issues![indexPath.row])!
        if let n = comicvine.issueNumber {
        cell.textLabel?.text = comicvine.name! + " " + n
        } else {
            cell.textLabel?.text = comicvine.name!
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
