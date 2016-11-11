//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by MAIN on 11.10.16.
//  Copyright © 2016 University of Washington. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var cat: String = ""
    var questions: [String: [(String, String)]] = ["Mathematics": [("What is 2+2?", "4"), ("What is 8 X 8?", "64")],
                                         "Marvel Super Heroes": [("What is Thor's weapon of choice?", "A hammer"), ("What is Spider-Man's real name?", "Peter Parker")],
                                         "Science": [("What is the biggest plannet in our solar system?", "Jupiter"), ("What is the chemical symbol for the element Gold?", "Au")]]
    var answers: [String: [[String]]] = ["Mathematics": [["0", "-4", "2", "4"], ["64", "46", "88", "16"]],
                                       "Marvel Super Heroes": [["A hammer", "A sword", "An apple", "A shield"], ["Tony Parker", "Peter Parker", "Ben Parker", "Bruce Banner"]],
                                       "Science": [["Earth", "Neptune", "Jupiter", "Mars"], ["Ag", "Gd", "Ga", "Au"]]]
    var isQuestion: Bool = true
    var numCorrect: Int  = 0
    var index: Int  = 0
    @IBOutlet weak var qView: UIView!
    @IBOutlet weak var qLabel: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        qLabel.text = questions[cat]?[index].0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[cat]![index][row]
    }
    
    @IBAction func tapNext(_ sender: UIButton) {
        if isQuestion {
            if index < (questions[cat]?.count)! {
                self.pickerView.isHidden = true
            }
        } else {
            self.pickerView.isHidden = false
            index += 1
            
            
        }
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
