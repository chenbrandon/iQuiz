//
//  QuizTableViewCell.swift
//  iQuiz
//
//  Created by Brandon Chen on 5/1/17.
//  Copyright © 2017 Brandon Chen. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
