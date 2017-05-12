//
//  QuizTableViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/1/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController {
    @IBOutlet var theTableView: UITableView!

    @IBAction func settingsPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "After entering, please wait a few seconds", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default)
        alert.addAction(cancel)
        alert.addTextField { (textField) in
            textField.attributedPlaceholder = NSAttributedString(string:"URL", attributes:[NSForegroundColorAttributeName: UIColor.gray])
        }
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { (_) in
            self.url = alert.textFields![0].text!
            //self.url = "https://tednewardsandbox.site44.com/questions.json"
            self.getJSON(self.url)
        }))
        self.present(alert, animated: true)
    }
    var url = "https://tednewardsandbox.site44.com/questions.json"
    func getJSON(_ url: String) { // http://stackoverflow.com/questions/38292793/http-requests-in-swift-3
        if let theURL = URL(string: url) {
            let task = URLSession.shared.dataTask(with: theURL) { data, response, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                self.quiz = self.quiz2
                self.descriptions = self.descriptions2
                self.questions = self.questions2
                self.answers = self.answers2
                self.correctAnswers = self.correctAnswers2
                let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Dictionary<String, AnyObject>]
                for i in json! {
                    let thisSubject = i["title"]
                    let thisDesc = i["desc"]
                    let questionsArray:[[String: Any]] = i["questions"] as! [[String : Any]]
                    var sumQuestions: [String] = []
                    var sumAnswers: [[String]] = []
                    var sumCorrect: [Int] = []
                    for j in questionsArray {
                        let questionText: String = j["text"] as! String
                        let answerNumber: Int = Int(j["answer"] as! String)!
                        let answersArray: [String] = j["answers"] as! [String]
                        sumQuestions.append(questionText)
                        sumAnswers.append(answersArray)
                        sumCorrect.append(answerNumber)
                    }
                    self.quiz.append(thisSubject as! String)
                    self.descriptions.append(thisDesc as! String)
                    self.questions.append(sumQuestions)
                    self.answers.append(sumAnswers)
                    self.correctAnswers.append(sumCorrect)
                }
            }
            task.resume()
            self.tableView.dataSource = self
        } else {
            let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .default)
            alert.addAction(cancel)
            self.present(alert, animated: true)
        }
        refresh()
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + 5)) {
            print("calling reload")
            UserDefaults.standard.setValue(self.quiz, forKey: "subjects")
            UserDefaults.standard.setValue(self.descriptions, forKey: "descriptions")
            UserDefaults.standard.setValue(self.questions, forKey: "questions")
            UserDefaults.standard.setValue(self.answers, forKey: "answers")
            UserDefaults.standard.setValue(self.correctAnswers, forKey: "correctAnswers")
            UserDefaults.standard.synchronize()
            self.tableView.reloadData()

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.quiz = UserDefaults.standard.value(forKey: "subjects") as! [String]
        //self.descriptions = UserDefaults.standard.value(forKey: "descriptions") as! [String]
        //self.questions = UserDefaults.standard.value(forKey: "questions") as! [[String]]
        //self.answers = UserDefaults.standard.value(forKey: "answers") as! [[[String]]]
        //self.correctAnswers = UserDefaults.standard.value(forKey: "correctAnswers") as! [[Int]]

        getJSON(self.url)
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
    var quiz: [String] = UserDefaults.standard.value(forKey: "subjects") as! [String]
    var descriptions: [String] = UserDefaults.standard.value(forKey: "descriptions") as! [String]
    var questions : [[String]] = UserDefaults.standard.value(forKey: "questions") as! [[String]]
    var answers : [[[String]]] = UserDefaults.standard.value(forKey: "answers") as! [[[String]]]
    
    var correctAnswers: [[Int]] = UserDefaults.standard.value(forKey: "correctAnswers") as! [[Int]]
    
    var quiz2: [String] = ["My Math ", "My Marvel", "My Science","My Luck"]
    var descriptions2: [String] = ["Test your math skills",
                                  "Test your knowledge of Marvel",
                                  "Test your understanding of the world",
                                  "Test your Luck"]
    var questions2 : [[String]] = [
        ["Is 2 + 2 = 22 ?", "what is 5! ?"],
        ["Who is iron man"],
        ["What is water"],
        ["Pick an option", "Pick another option", "Pick a final option"]
    ]
    var answers2 : [[[String]]] = [
        [["no","yes","It's a trick question","Hillary's Emails"], ["when you shout 5", "1", "120", "0"]],
        [["Tony Hawk", "Tony Stark", "Ronald McDonald", "Kaiba"]],
        [["H20","Click here!","Yugi","C3H8 Propane"]],
        [["1", "2", "3", "4"], ["1","2","3","4"],["1","2","3","4"]]
    ]
    var correctAnswers2: [[Int]] = [[1,3], [2], [1], [3, 3, 4]]
    
    
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
            }
        }
    }
    

}
