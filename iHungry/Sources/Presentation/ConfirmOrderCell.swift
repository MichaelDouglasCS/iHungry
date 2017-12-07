//
//  ConfirmOrderCell.swift
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

class ConfirmOrderCell: UITableViewCell {

    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
    
    @IBOutlet weak var foodImage: RoundedImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    
    //*************************************************
    // MARK: - Override Public Methods
    //*************************************************

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
