//
//  QuestionConfirmOrderCell.swift
//  iHungry
//
//  Created by Michael Douglas on 24/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import UIKit

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class QuestionConfirmOrderCell: UITableViewCell {

    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
   
    @IBOutlet weak var questionConfirmOrder: UILabel!
    
    //*************************************************
    // MARK: - Override Public Methods
    //*************************************************
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
