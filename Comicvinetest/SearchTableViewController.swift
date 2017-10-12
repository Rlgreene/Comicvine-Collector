//
//  SearchTableViewController.swift
//  Comicvinetest
//
//  Created by Richard Greene on 10/4/17.
//  Copyright © 2017 Richard Greene. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var comicvineResults: [Comicvine]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.comicvineResults = [Comicvine]()
        
    }
    
    func searchComicsBy(_ searchString: String){
        let manager = AFHTTPSessionManager()
        
        let searchParameters:[String:Any] = ["api_key": "6121b778a49a69f39054e929a1b6d89d74d74e10",
                                             "format": "json",
                                             "limit": 20,
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
                                print(result["volume"]!["name"], result["issue_number"]!, result["image"]!["medium_url"])
                                let c = Comicvine(issueNumber: result["issue_number"] as? String, name: result["volume"]?["name"] as? String)
                                let i = Comicvine(cover: result["image"]?["medium_url"] as? String as? CGImage)
                                for (i,result) in results {
                                if let imageURLString = result["image"]?["medium_url"] as? String {
                                    let imageData = NSData(contentsOf: URL(string: imageURLString)!)
                                    if let imageDataUnwrapped = imageData {
                                    let imageView = UIImageView(image: UIImage(data: imageDataUnwrapped as Data))
                                        imageView.frame = CGRect(x: 0, y: 320 * CGFloat(i), width: 320, height: 320)
                                    if let url = URL(string: imageURLString) {
                                        imageView.setImageWith(url)
                                        self.comicvineResults?.append(c)
                                        }
                                    }
                                    }
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
        for subview in self.tableView.subviews{
            subview.removeFromSuperview()
        }
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            searchComicsBy(searchText)
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comics", for: indexPath)
        
        let c: Comicvine = (comicvineResults? [indexPath.row])!
        cell.textLabel?.text = c.name! + " " + c.issueNumber!
        
        

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

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
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let comicvine = self.comicvineResults![(indexPath?.row)!]
        let destination = segue.destination as! SearchDetailsViewController
        destination.comicvine = comicvine        
    }
    

}
