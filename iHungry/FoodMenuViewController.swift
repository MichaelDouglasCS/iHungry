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
    @IBOutlet weak var nextButton: UIButton!
    
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
        let customCell = Bundle.main.loadNibNamed("FoodMenuCustomTableViewCell", owner: self, options: nil)?.first as! FoodMenuCustomTableViewCell
        
        customCell.addFood.tag = indexPath.row
        customCell.addFood.addTarget(self, action: #selector(FoodMenuViewController.addFood), for: UIControlEvents.touchUpInside)
        
        customCell.removeFood.tag = indexPath.row
        customCell.removeFood.addTarget(self, action: #selector(FoodMenuViewController.removeFood), for: UIControlEvents.touchUpInside)
        
        if let foodImage = self.foods[indexPath.row].image {
            customCell.foodImage?.image = UIImage(named: foodImage)
        }
        if let foodName = self.foods[indexPath.row].name {
            customCell.foodName?.text = foodName
        }
        if let foodPrice = self.foods[indexPath.row].price {
            customCell.foodPrice?.text = foodPrice.toReal()
        }
        if let foodQuantity = self.foods[indexPath.row].quantity {
            self.hasSomeFood()
            if foodQuantity == 0 {
                customCell.removeFood.isEnabled = false
            }
            customCell.foodQuantity?.text = foodQuantity.toString()
        }
        return customCell
    }
    
    //*************************************************
    // MARK: - Internal Methods
    //*************************************************
    
    internal func hasSomeFood() {
        var quantity = Int()
        for food in self.foods {
            quantity = quantity + food.quantity!
        }
        if quantity != 0 {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
    }
    
    internal func addFood(button: UIButton) {
        if let quantity = self.foods[button.tag].quantity {
            self.foods[button.tag].quantity = (quantity + 1)
        }
        self.hasSomeFood()
        self.foodMenuTableView.reloadData()
    }
    
    internal func removeFood(button: UIButton) {
        if let quantity = self.foods[button.tag].quantity {
            if quantity != 0 {
                self.foods[button.tag].quantity = (quantity - 1)
            } else {
                button.isEnabled = false
            }
        }
        self.hasSomeFood()
        self.foodMenuTableView.reloadData()
    }
    
    //*************************************************
    // MARK: - IBAction
    //*************************************************
    
    @IBAction func touchNextButton(_ sender: UIButton) {
        
        let confirmOrderVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmOrderViewController") as! ConfirmOrderViewController
        
        var foodOrder = [FoodVO]()
        for food in self.foods {
            if food.quantity != 0 {
                foodOrder.append(food)
            }
        }
        
        confirmOrderVC.foodsOfOrder = foodOrder
        
        let modalViewController = confirmOrderVC
        modalViewController.modalPresentationStyle = .overFullScreen
        present(modalViewController, animated: true, completion: nil)
        
        //        var foodOrder = [FoodVO]()
        //        for food in self.foods {
        //            if food.quantity != 0 {
        //                foodOrder.append(food)
        //            }
        //        }
        //        let myOrder = OrderVO(orderFromFood: foodOrder)
        //        OrderManager.insertOrder(orderVO: myOrder)
        //        if let navControlle = self.navigationController {
        //            navControlle.popViewController(animated: true)
        //        }
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
        let currencyValue = NumberFormatter.localizedString(from: self as NSNumber, number: NumberFormatter.Style.currency)
        let formatValue = currencyValue.replacingOccurrences(of: "R$", with: "R$ ")
        return ("\(formatValue)")
    }
}
extension Int {
    func toString() -> String {
        return String(self)
    }
}
