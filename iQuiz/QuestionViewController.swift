//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/4/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var theSubject: String!
    var theQuestion: [String]!
    var answers: [[String]]!
    var correct: [Int]!
    var selected: Int = -1
    var number: Int!
    var score: Int!
    
    
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    
    @IBAction func a1press(_ sender: Any) {
        selected = 1
        ans1.isSelected = true
        ans2.isSelected = false
        ans3.isSelected = false
        ans4.isSelected = false
        nextButton.isHidden = false
    }
    @IBAction func a2press(_ sender: Any) {
        selected = 2
        ans1.isSelected = false
        ans2.isSelected = true
        ans3.isSelected = false
        ans4.isSelected = false
        nextButton.isHidden = false
    }
    @IBAction func a3press(_ sender: Any) {
        selected = 3
        ans1.isSelected = false
        ans2.isSelected = false
        ans3.isSelected = true
        ans4.isSelected = false
        nextButton.isHidden = false
    }
    @IBAction func a4press(_ sender: Any) {
        selected = 4
        ans1.isSelected = false
        ans2.isSelected = false
        ans3.isSelected = false
        ans4.isSelected = true
        nextButton.isHidden = false
    }
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test \(subject)  \(question) \(answers) + \(correct) ")
        ans1.setTitle(answers[number][0], for: .normal)
        ans2.setTitle(answers[number][1], for: .normal)
        ans3.setTitle(answers[number][2], for: .normal)
        ans4.setTitle(answers[number][3], for: .normal)
        question.text = theQuestion[number]
        subject.text = theSubject
        nextButton.isHidden = true
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.	
        if segue.identifier == "questionToAnswer", let avc = segue.destination as? AnswerViewController {
            avc.theSubject = theSubject
            avc.theQuestion = theQuestion
            avc.answers = answers
            avc.correct = correct
            avc.selected = selected
            avc.number = number
            avc.score = score
        }
    }
    

}
