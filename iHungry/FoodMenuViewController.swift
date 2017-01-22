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
        return self.foods.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("FoodMenuCustomTableViewCell", owner: self, options: nil)?.first as! FoodMenuCustomTableViewCell
        
        let foodCell = self.foods[indexPath.row]
        
        if let foodImage = foodCell.image {
            cell.foodImage?.image = UIImage(named: foodImage)
        }
        if let foodName = foodCell.name {
            cell.foodName?.text = foodName
        }
        if let foodPrice = foodCell.price {
            cell.foodPrice?.text = foodPrice.toReal()
        }
        
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
// MARK: - Extension - Double
//
//**************************************************************************************************

extension Double {
    func toReal() -> String {
        let value = self
        let formatValue = String(format: "%.2f", value)
        return ("R$ \(formatValue)")
    }
}
