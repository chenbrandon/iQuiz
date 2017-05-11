//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/4/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {
    var theSubject: String!
    var theQuestion: [String]!
    var answers: [[String]]!
    var correct: [Int]!
    var selected: Int!
    var number: Int!
    var score: Int!
    @IBOutlet weak var answer: UILabel!
    @IBOutlet weak var gotRight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let actual = correct[number]
        answer.text = answers[number][actual - 1]
        if selected == actual {
            gotRight.text = "You got the answer right"
            score! += 1
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        var identifier = "answerToQuestion"
        if number + 1 == theQuestion.count {
            identifier = "answerToResults"
        }
        self.performSegue(withIdentifier: identifier, sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if number + 1 == theQuestion.count {
            if let results = segue.destination as? FinishedViewController {
                results.total = theQuestion.count
                results.right = score
            }
        } else {
            if let qvc = segue.destination as? QuestionViewController {
                qvc.theQuestion = theQuestion
                qvc.theSubject = theSubject
                qvc.answers = answers
                qvc.correct = correct
                qvc.number = number + 1
                qvc.score = score
            }
        }
        
    }


}
