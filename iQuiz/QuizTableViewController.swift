//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/1/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {

    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return quiz.count
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuizCell", for: indexPath) as! QuizTableViewCell
        let subject = quiz[indexPath.row]
        cell.Title.text = (subject)
        cell.Description.text = descriptions[indexPath.row]
        if let icon =  UIImage(named: subject) {
            cell.icon.image = icon
        } else {
            cell.icon.image = UIImage(named: "defaultIcon")
        }
        //cell.icon.image = UIImage(named: subject)
        return cell
    }
    
    let quiz: [String] = ["Mathematics", "Marvel Super Heroes", "Science!","Luck"]
    let descriptions: [String] = ["Test your math skills",
                                  "Test your knowledge of Marvel",
                                  "Test your understanding of the world",
                                  "Test your Luck"]
    var questions : [[String]] = [
        ["Is 2 + 2 = 22 ?", "what is 5! ?"],
        ["Who is iron man"],
        ["What is water"],
        ["Pick an option", "Pick another option", "Pick a final option"]
    ]
    var answers : [[[String]]] = [
        [["no","yes","It's a trick question","Hillary's Emails"], ["when you shout 5", "1", "120", "0"]],
        [["Tony Hawk", "Tony Stark", "Ronald McDonald", "Kaiba"]],
        [["H20","Click here!","Yugi","C3H8 Propane"]],
        [["1", "2", "3", "4"], ["1","2","3","4"],["1","2","3","4"]]
    ]
    
    var correctAnswers: [[Int]] = [[1,3], [2], [4], [3, 3, 4]]
    
    
    func getSubject(_ n: Int) -> String {
        return quiz[n]
    }
    
    func getQuestion(_ n: Int) -> [String] {
        return questions[n]
    }
 
    func getAnswers(_ n: Int) -> [[String]] {
        return answers[n]
    }
    
    func getCorrect(_ n: Int) -> [Int] {
        return correctAnswers[n]
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "cellToQuestion", let qvc = segue.destination as? QuestionViewController {
            if let cell = sender as? UITableViewCell, let index = tableView.indexPath(for: cell) {
                let subjectNumber: Int = index.row
                let subject: String = getSubject(subjectNumber)
                let question: [String] = getQuestion(subjectNumber)
                let answers:[[String]] = getAnswers(subjectNumber)
                let correctAnswers: [Int] = getCorrect(subjectNumber)
                qvc.theSubject = subject
                qvc.theQuestion = question
                qvc.answers = answers
                qvc.correct = correctAnswers
                qvc.number = 0
                qvc.score = 0
                /* //filler
                let subject: String = "theSubject"
                let question: [String] = ["theQuestion", "theQuestion2"]
                let answers:[[String]] = [["a1", "a2", "a3", "a4"], ["b1","b2","b3","b4"]]
                let correct: [Int] = [2, 4]
 
                qvc.theSubject = subject
                qvc.theQuestion = question
                qvc.answers = answers
                qvc.correct = correct
                qvc.number = 0
                qvc.score = 0
                */
                
            }
        }
    }
    

}
