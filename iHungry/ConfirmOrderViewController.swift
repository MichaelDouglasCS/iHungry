//
//  ConfirmOrderViewController.swift
//  iHungry
//
//  Created by Michael Douglas on 23/01/17.
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

class ConfirmOrderViewController: UIViewController {
    
    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
    
    //*************************************************
    // MARK: - Override Public Methods
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    
    //*************************************************
    // MARK: - IBActions
    //*************************************************
    
    @IBAction func cancelConfirmation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
