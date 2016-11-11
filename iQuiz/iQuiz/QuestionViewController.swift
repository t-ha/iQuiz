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
    var finished: Bool = false
    var numCorrect: Int  = 0
    var index: Int  = 0
    var pickedAnswer: String = ""
    @IBOutlet weak var qLabel: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var yourAnswer: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        answerLabel.isHidden = true
        correctAnswerLabel.isHidden = true
        yourAnswer.isHidden = true
        pickedAnswer = answers[cat]![index][0]
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedAnswer = answers[cat]![index][row]
    }
    
    @IBAction func swipeLeftBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func swipeRightNext(_ sender: Any) {
        tapGo(Any.self)
    }
    
    @IBAction func tapGo(_ sender: Any) {
        if finished {
            swipeLeftBack(Any.self)
        } else if isQuestion {
            nextButton.setTitle("Next", for: .normal)
            self.pickerView.isHidden = true
            self.answerLabel.isHidden = false
            self.correctAnswerLabel.isHidden = false
            self.yourAnswer.isHidden = false
            let correctAnswer = questions[cat]![index].1
            self.correctAnswerLabel.text = "Answer: \(correctAnswer)"
            
            yourAnswer.text = "Your answer: \(pickedAnswer)"
            
            if pickedAnswer == correctAnswer {
                answerLabel.text = "CORRECT"
                numCorrect += 1
            } else {
                answerLabel.text = "INCORRECT"
            }
            index += 1
        } else if index < (questions[cat]?.count)! {
            pickedAnswer = answers[cat]![index][0]
            nextButton.setTitle("Submit", for: .normal)
            self.pickerView.isHidden = false
            self.answerLabel.isHidden = true
            self.correctAnswerLabel.isHidden = true
            self.yourAnswer.isHidden = true
            qLabel.text = questions[cat]?[index].0
            pickerView.dataSource = self
        } else {
            pickerView.removeFromSuperview()
            correctAnswerLabel.removeFromSuperview()
            yourAnswer.removeFromSuperview()
            let accuracy: Double = Double(numCorrect) / Double(index)
            if accuracy == 100.0 {
                answerLabel.text = "Perfect!"
            } else if accuracy >= 75.0 {
                answerLabel.text = "Almost!"
            } else if accuracy >= 40.0 {
                answerLabel.text = "Try again."
            } else {
                answerLabel.text = "Sorry."
            }
            qLabel.text = "You got \(numCorrect) out of \(index) correct."
            nextButton.setTitle("Finish", for: .normal)
            finished = true
        }
        isQuestion = !isQuestion
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
