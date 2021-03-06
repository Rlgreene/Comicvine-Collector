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
    var newComics: [Comicvine] = []
    var comicvine: Comicvine?
    var newComic: Comicvine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Shelves"
        
        let addButton = UIBarButtonItem (barButtonSystemItem: .add, target: self, action: #selector(CollectionTableViewController.addCollection))
        navigationItem.rightBarButtonItem = addButton
        
        let moveButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(CollectionTableViewController.toggleEdit))
        navigationItem.leftBarButtonItem = moveButton

        
        if !initialLoad{
          print("initial load")
        
        //Displays data that was saved from the previous session from the collections.dat folder when the "saveCollections" UIButton or the autoSave action is called
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

    //Controls cell transparency
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.75)
    }
    
    //Cell configuration
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "collections", for: indexPath)
        let collection = self.collections [indexPath.row]
        
        /*let coverThumbnail = cell.viewWithTag(12) as! UIImageView
        coverThumbnail.image = UIImage(data: comicvine!.cover!, scale: collections.first)*/
        
        //label tag that describes the number of issue items within the corresponding collection cell
        let numlabel = cell.viewWithTag(11) as! UILabel
        numlabel.text = "\(String(describing: collection.issues!.count)) books"
        
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
        autoSave()
        self.tableView.reloadData()
        autoSave()
        print("autoSave will appear")
        
        //tableView background picture
        let backgroundImage = UIImage(named: "background4Longbox.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    @objc func addCollection () {
        let newCollection = Collection(name: "New Shelf")
        self.collections.append(newCollection)
        let newIndexPath = IndexPath(row: self.collections.count - 1, section: 0)
        self.tableView.insertRows(at: [newIndexPath], with: .right)
        autoSave()
        print("autoSaved add")
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.collections.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            autoSave()
            print("autoSaved delete")
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    //when adding from SearchTableView or DetailsView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c = collections[indexPath.row]
        for comicvine in newComics {
            c.addIssue(issue: comicvine)
        }
        newComics = []
        //creates empty array so just tapping a collection cell without the intention of adding doesnt add previously added issues
    }
    
    
    //Sends the selected data from SearchTableViewController to this vc via unwind segue to avoid creating a duplicate vc (called first in Search's prepareforsegue)
    @IBAction func unwindToCollectionsTableView(sender: UIStoryboardSegue)
    {
        let sourceViewController = sender.source as! SearchTableViewController
        newComics = sourceViewController.selectedComics!
        // Pull any data from the view controller that initiated the unwind segue and fill the newComics array.
        
        sourceViewController.selectedComics = []
        //reset the array of selected comics to clear up for the next add cycle
    }
    
    //Does the same as the block above just with a different sourceVC
    @IBAction func unwindFromDetailsView(sender: UIStoryboardSegue)
    {
     let sourceViewController = sender.source as! SearchDetailsViewController
        newComics = [sourceViewController.comicvine!]
    }
    
    
    @objc func toggleEdit(isEditing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        
        print("toggle")
    }
    
    //configure the Edit button's display
    func movebuttonTitle(isEditing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        let item = self.navigationItem.leftBarButtonItem
        let button = item?.customView as? UIButton
        button?.setTitle("Move", for: .normal)
        print("movebutton")
    }
    //the rearranging func
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let collectionMoving = collections.remove(at: fromIndexPath.row)
        collections.insert(collectionMoving, at: to.row)
        autoSave()
        tableView.reloadData()
        print("reloaded rearranging")
    }
    
    //Call this function after any method that edits so that changes are saved
    func autoSave() {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(documentsPath)
        let savePath = documentsPath + "/collections.dat"
        print(savePath)
        NSKeyedArchiver.archiveRootObject(collections, toFile: savePath)
    }

   
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
