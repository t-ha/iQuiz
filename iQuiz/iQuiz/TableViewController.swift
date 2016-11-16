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
    
    let url = "http://tednewardsandbox.site44.com/questions.json"
    let catIcons = [#imageLiteral(resourceName: "scienceIcon"), #imageLiteral(resourceName: "marvelIcon"), #imageLiteral(resourceName: "mathIcon")]
    var categories: [String] = []
    var catDescr: [String] = []
    var questions = [String: [(String, String)]]()
    var answers = [String: [[String]]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getData() {
        let urlString: URL = URL(string: url)!
        URLSession.shared.dataTask(with: urlString) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [[String:Any]]
                    for section in json {
                        let title = section["title"]! as! String
                        if let catQuestions = section["questions"] as? [[String:Any]] {
                            var tempQ: [(String,String)] = []
                            var tempA: [[String]] = []
                            for temp in catQuestions {
                                var tempArray = temp["answers"]! as! [String]
                                let answerIndex = Int(temp["answer"]! as! String)! - 1
                                tempQ.append((temp["text"]! as! String, tempArray[answerIndex]))
                                tempA.append(tempArray)
                            }
                            self.questions[title] = tempQ
                            self.answers[title] = tempA
                        }
                        self.categories.append(title)
                        self.catDescr.append(section["desc"]! as! String)
                    }
                } catch {
                    print("error serializing JSON \(error)")
                }
            }
        }.resume()
    }
    
    @IBAction func tapSettings(_ sender: Any) {
        let alertController = UIAlertController(title: "Settings go here", message: "", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
            let path = self.tableView.indexPathForSelectedRow!
            let cat = categories[path[1]]
            controller.cat = cat
            controller.url = url
            controller.questions = questions
            controller.answers = answers
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

