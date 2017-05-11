//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/4/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    var theTitle: String!
    var subject: String!
    var question: String!
    var answers: [String]!
    var correct: Int!
    
    
    
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test \(theTitle) \(subject)  \(question) \(answers) + \(correct) ")
        ans1.setTitle(answers[0], for: .normal)
        ans2.setTitle(answers[1], for: .normal)
        ans3.setTitle(answers[2], for: .normal)
        ans4.setTitle(answers[3], for: .normal)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
