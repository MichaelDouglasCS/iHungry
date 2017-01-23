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
        
    }
    
    //*************************************************
    // MARK: - Table View Methods
    //*************************************************
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.foods.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Instantiete Custom Cell
        let cell = Bundle.main.loadNibNamed("FoodMenuCustomTableViewCell", owner: self, options: nil)?.first as! FoodMenuCustomTableViewCell
        
        cell.addFood.tag = indexPath.row
        cell.addFood.addTarget(self, action: #selector(FoodMenuViewController.addFood), for: UIControlEvents.touchUpInside)
        
        cell.removeFood.tag = indexPath.row
        cell.removeFood.addTarget(self, action: #selector(FoodMenuViewController.removeFood), for: UIControlEvents.touchUpInside)
        
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
        if let foodQuantity = foodCell.quantity {
            if foodQuantity == 0 {
                cell.removeFood.isEnabled = false
            }
            cell.foodQuantity?.text = foodQuantity.toString()
        }
        
        return cell
        
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    internal func addFood(button: UIButton) {
        let foodCell = self.foods[button.tag]
        if let quantity = foodCell.quantity {
            foodCell.quantity = (quantity + 1)
        }
        self.foodMenuTableView.reloadData()
    }
    
    internal func removeFood(button: UIButton) {
        let foodCell = self.foods[button.tag]
        if let quantity = foodCell.quantity {
            if quantity != 0 {
            foodCell.quantity = (quantity - 1)
            } else {
                button.isEnabled = false
            }
        }
        self.foodMenuTableView.reloadData()
    }
    
    //*************************************************
    // MARK: - IBAction
    //*************************************************
    
    @IBAction func nextButton(_ sender: UIButton) {
        var foodOrder = [FoodVO]()
        for food in self.foods {
            if food.quantity != 0 {
            foodOrder.append(food)
            }
        }
        let myOrder = OrderVO(foodOrder: foodOrder)
        OrderManager.insertOrder(orderVO: myOrder)
    }
    
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
extension Int {
    func toString() -> String {
        return String(self)
    }
}
