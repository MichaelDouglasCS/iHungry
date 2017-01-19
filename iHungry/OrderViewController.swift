//
//  OrderViewController.swift
//  iHungry
//
//  Created by Michael Douglas on 18/01/17.
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

class OrderViewController: UIViewController {
    
//*************************************************
// MARK: - Properties
//*************************************************
    @IBOutlet weak var textField: UITextField!
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
    @IBAction func saveOrder(_ sender: UIButton) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let order = OrderDB(context: context)
        order.name = textField.text!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController?.popViewController(animated: true)
        
    }
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
}

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************
