//
//  TableViewController.swift
//  iQuiz
//
//  Created by MAIN on 11.03.16.
//  Copyright © 2016 University of Washington. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    @IBOutlet var quizTableView: UITableView!
    
    let categories = ["Mathematics", "Marvel Super Heroes", "Science"]
    let catDescr = ["Something with numbers", "How well do you know The Hulk?", "Some more numbers"]
    let catIcons = [#imageLiteral(resourceName: "mathIcon"), #imageLiteral(resourceName: "marvelIcon"), #imageLiteral(resourceName: "scienceIcon")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func tapSettings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath as IndexPath)
        cell.textLabel?.text = categories[indexPath.item]
        cell.detailTextLabel?.text = catDescr[indexPath.item]
        cell.imageView?.image = catIcons[indexPath.item]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegue(withIdentifier: "cellToQ", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "cellToQ") {
            let controller = segue.destination as! QuestionViewController
//            let rows = (sender as! NSIndexPath).row
            let path = self.tableView.indexPathForSelectedRow!
//            let row = tableView.indexPathForSelectedRow
//            let row = IndexPath
//            print(path)
            let cat = categories[path[1]]
            controller.cat = cat
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

