//
//  FoodMenuViewController.swift
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

class FoodMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//*************************************************
// MARK: - IBOutlet
//*************************************************
    
    @IBOutlet weak var foodMenuTableView: UITableView!
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    //Variable that storages the Foods that appears in TableView
    var foods = [FoodVO]()
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Remove UITableViewCell separator for empty cells
        self.foodMenuTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.foods)
    }
    
//*************************************************
// MARK: - Table View Methods
//*************************************************
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("FoodMenuCustomTableViewCell", owner: self, options: nil)?.first as! FoodMenuCustomTableViewCell
        
//        let orderCell = self.orders[indexPath.row]
//        
//        cell.orderName?.text = orderCell.name
        
        return cell
    }
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - IBAction
//*************************************************
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        if let navControlle = self.navigationController {
            navControlle.popViewController(animated: true)
        }
    }
    
}

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************
