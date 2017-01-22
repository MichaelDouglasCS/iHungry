//
//  FoodMenuCustomTableViewCell.swift
//  iHungry
//
//  Created by Michael Douglas on 20/01/17.
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

class FoodMenuCustomTableViewCell: UITableViewCell {
    
//*************************************************
// MARK: - IBOutlets
//*************************************************

    @IBOutlet weak var foodImage: RoundedImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodQuantity: UILabel!
    @IBOutlet weak var addFood: UIButton!
    @IBOutlet weak var removeFood: UIButton!
    
//*************************************************
// MARK: - Override Methods
//*************************************************
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
