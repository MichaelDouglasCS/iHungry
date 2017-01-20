//
//  HomeCustomTableViewCell.swift
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

class HomeCustomTableViewCell: UITableViewCell {

//*************************************************
// MARK: - IBOutlets
//*************************************************
    
    @IBOutlet weak var orderImage: RoundedImageView!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderPrice: UILabel!

//*************************************************
// MARK: - Override Methods
//*************************************************

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
