//
//  SearchTableViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/4/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var collection: Collection?
    var comicvineResults: [Comicvine]?
    var selectedComics: [Comicvine]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comicvineResults = [Comicvine]()
        navigationItem.title = "Search to Add"
        
        selectedComics = []

    }
    
    func searchComicsBy(_ searchString: String){
        let manager = AFHTTPSessionManager()
        
        let searchParameters:[String:Any] = ["api_key": "6121b778a49a69f39054e929a1b6d89d74d74e10",
                                             "format": "json",
                                             "limit": comicvineResults?.count as Any,
                                             "query": searchString,
                                             "resources": "issue",
                                             "resource-type": "issue"
                                            ]
        
        manager.get("https://comicvine.gamespot.com/api/search/",
                    parameters: searchParameters,
                    progress: nil,
                    success: { (operation: URLSessionDataTask, responseObject:Any?) in
                        if let responseObject = responseObject as? [String: AnyObject] {
                            print("Response: " + (responseObject as AnyObject).description)
                            if let results = responseObject["results"] as? [[String: AnyObject]] {
                            self.comicvineResults = [Comicvine]()
                            for result in results {
                                print(result["volume"]!["name"], result["issue_number"]!, result["image"]!["medium_url"], result["cover_date"]!)
                                let c = Comicvine(issueNumber: result["issue_number"] as? String, name: result["volume"]?["name"] as? String, date: result["cover_date"] as? String)
        //'if let' below parses the location of the cover art (rest of the code that loads it is on the corresponding details VC)
                                if let imageURLString = result["image"]?["medium_url"] as? String {
                                    c.coverUrl = imageURLString
                                    
                                    self.comicvineResults?.append(c)
                                }
                            }
                            self.tableView.reloadData()
                            }
                        }
                        
        }) { (operation:URLSessionDataTask?, error:Error) in
            print("Error: " + error.localizedDescription)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchComicsBy(searchText)
            SVProgressHUD.show(withStatus: "Looking for books")
        }
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
        
        return (comicvineResults?.count)!
    }
    
    //Cell transparency
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.55)
    }

    //Cell Configuration
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comics", for: indexPath)
        
        let comicvine = (comicvineResults? [indexPath.row])!
        if let d = comicvine.date {
            cell.textLabel?.text = comicvine.name! + " " + comicvine.issueNumber! + ": " + d
        } else {
            cell.textLabel?.text = comicvine.name! + " " + comicvine.issueNumber!
        }
        
        SVProgressHUD.dismiss()
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //tableView background picture
        let backgroundImage = UIImage(named: "wood_shelves-1.jpg")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFit
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    //Next two funcs enable selection and deselection of cells displaying a checkmark, used for adding comics to collections
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        let comicvine = comicvineResults![indexPath.row]
        selectedComics?.append(comicvine)
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .detailDisclosureButton
        let comicvine = comicvineResults![indexPath.row]
        let s = selectedComics?.index(of: comicvine)
        selectedComics?.remove(at: s!)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchDisclosure"){
            SVProgressHUD.show(withStatus: "Getting Book")
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let comicvine = self.comicvineResults![(indexPath?.row)!]
        let destination = segue.destination as! SearchDetailsViewController
        destination.comicvine = comicvine
        destination.collection = collection
        }
        
        
        if (segue.identifier == "addComics") {
            let destination = segue.destination as! CollectionTableViewController
            destination.newComics = selectedComics!
        }
    }
    

}
