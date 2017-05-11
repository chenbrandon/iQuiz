//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/4/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    var total: Int!
    var right: Int!
    @IBOutlet weak var banter: UILabel!
    @IBOutlet weak var scored: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        scored.text = "You scored \(right!) / \(total!)"
        var message = "That was close!"
        if right == total {
            message = "Perfect!"
        } else if right == 0 {
            message = "That was a terrible performance"
        }
        banter.text = message
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
