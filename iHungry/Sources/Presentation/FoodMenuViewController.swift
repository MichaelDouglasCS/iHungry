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

class FoodMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
    
    @IBOutlet weak var backgroundOrderDetail: UIView!
    @IBOutlet weak var centerOrderDetail: NSLayoutConstraint!
    @IBOutlet weak var orderDetailTableView: UITableView!
    @IBOutlet weak var foodMenuTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    //Variable that storages the Foods received
    var receivedFoods = [FoodVO]()
    
    //Variable that storages the Foods that select to order
    var foodsOfOrder = [FoodVO]()
    var observationOrder = String()
    
    var questionCellPosition: Int {
        get{
            return 0
        }
    }
    var rangeOfFoodEndPosition: Int {
        get{
            return self.foodsOfOrder.endIndex
        }
    }
    var anyObservationCellPosition: Int {
        get{
            return self.foodsOfOrder.endIndex + 1
        }
    }
    var totalPriceCelPosition: Int {
        get{
            return self.anyObservationCellPosition + 1
        }
    }
    var confirmButtonCellPosition: Int {
        get{
            return self.totalPriceCelPosition + 1
        }
    }
    
    //*************************************************
    // MARK: - Override Public Methods
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //Remove UITableViewCell separator for empty cells
        self.foodMenuTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.orderDetailTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //*************************************************
    // MARK: - IBAction
    //*************************************************
    
    @IBAction func touchNextButton(_ sender: UIButton) {
        var foodsSelected = [FoodVO]()
        for food in self.receivedFoods {
            if food.quantity != 0 {
                foodsSelected.append(food)
            }
        }
        self.foodsOfOrder = foodsSelected
        self.orderDetailTableView.reloadData()
        self.showOrderDetails()
    }
    
    @IBAction func cancelConfirmation(_ sender: UIButton) {
        self.closeOrderDetails()
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        if let navControlle = self.navigationController {
            navControlle.popViewController(animated: true)
        }
    }
    
    //*************************************************
    // MARK: - Text View Methods
    //*************************************************
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.orderDetailTableView.setContentOffset(CGPoint.init(x: 0, y: (100 * self.foodsOfOrder.count)), animated: true)
        self.orderDetailTableView.isScrollEnabled = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.orderDetailTableView.setContentOffset(CGPoint.init(x: 0, y: ((100 * self.foodsOfOrder.count) - 100)), animated: true)
        self.orderDetailTableView.isScrollEnabled = true
        self.observationOrder = textView.text
    }
    
    //*************************************************
    // MARK: - Table View Methods
    //*************************************************
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = Int()
        if tableView == self.foodMenuTableView {
            numberOfRows = self.receivedFoods.count
        } else if tableView == self.orderDetailTableView {
            if self.foodsOfOrder.count != 0 {
                numberOfRows = (self.foodsOfOrder.count + 4)
            } else {
                numberOfRows = 0
            }
        }
        return numberOfRows
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        // FOOD MENU
        if tableView == self.foodMenuTableView {
            //Instantiete Custom Cell
            let customCell = Bundle.main.loadNibNamed("FoodMenuCustomTableViewCell", owner: self, options: nil)?.first as! FoodMenuCustomTableViewCell
            
            customCell.addFood.tag = indexPath.row
            customCell.addFood.addTarget(self, action: #selector(FoodMenuViewController.addFood), for: UIControlEvents.touchUpInside)
            
            customCell.removeFood.tag = indexPath.row
            customCell.removeFood.addTarget(self, action: #selector(FoodMenuViewController.removeFood), for: UIControlEvents.touchUpInside)
            
            if let foodImage = self.receivedFoods[indexPath.row].image {
                customCell.foodImage?.image = UIImage(named: foodImage)
            }
            if let foodName = self.receivedFoods[indexPath.row].name {
                customCell.foodName?.text = foodName
            }
            if let foodPrice = self.receivedFoods[indexPath.row].price {
                customCell.foodPrice?.text = foodPrice.toReal()
            }
            if let foodQuantity = self.receivedFoods[indexPath.row].quantity {
                self.hasSomeFood()
                if foodQuantity == 0 {
                    customCell.removeFood.isEnabled = false
                }
                customCell.foodQuantity?.text = foodQuantity.toString()
            }
            cell = customCell
        }
            // ORDER DETAILS
        else if (tableView == self.orderDetailTableView) {
            //Verify indexPath.row to format Table View accornding to design
            //QuestionCell
            if indexPath.row == self.questionCellPosition {
                let questionConfirmCell = Bundle.main.loadNibNamed("QuestionConfirmOrderCell", owner: self, options: nil)?.first as! QuestionConfirmOrderCell
                return questionConfirmCell
            }
                //FoodsCell
            else if indexPath.row <= self.rangeOfFoodEndPosition {
                let confirmFoodsCell = Bundle.main.loadNibNamed("ConfirmOrderCell", owner: self, options: nil)?.first as! ConfirmOrderCell
                let positionCell = (indexPath.row - 1)
                if let image = self.foodsOfOrder[positionCell].image {
                    confirmFoodsCell.foodImage.image = UIImage(named: image)
                }
                if let name = self.foodsOfOrder[positionCell].name {
                    confirmFoodsCell.foodName.text = name
                }
                if let totalPrice = self.foodsOfOrder[positionCell].getFoodTotalPrice() {
                    confirmFoodsCell.foodPrice.text = totalPrice.toReal()
                }
                if let quantity = self.foodsOfOrder[positionCell].quantity {
                    confirmFoodsCell.foodQuantity.text = quantity.toString()
                }
                return confirmFoodsCell
            }
                //AnyObservation Cell
            else if indexPath.row == self.anyObservationCellPosition {
                let anyObservationCell = Bundle.main.loadNibNamed("AnyObservationCell", owner: self, options: nil)?.first as! AnyObservationCell
                anyObservationCell.tag = self.anyObservationCellPosition
                anyObservationCell.observationTextView.delegate = self
                anyObservationCell.observationTextView.text = self.observationOrder
                return anyObservationCell
            }
                //TotalPriceOrder Cell
            else if indexPath.row == self.totalPriceCelPosition {
                let totalPriceOrderCell = Bundle.main.loadNibNamed("TotalPriceOrderCell", owner: self, options: nil)?.first as! TotalPriceOrderCell
                
                if let totalPriceOrder = OrderVO.getOrderPrice(foods: self.foodsOfOrder) {
                    totalPriceOrderCell.foodPriceTotal.text = totalPriceOrder.toReal()
                }
                return totalPriceOrderCell
            }
                //ConfirmButtonCell
            else {
                let confirmButtonCell = Bundle.main.loadNibNamed("ConfirmButtonCell", owner: self, options: nil)?.first as! ConfirmButtonCell
                confirmButtonCell.confirmOrderButton.tag = indexPath.row
                confirmButtonCell.confirmOrderButton.addTarget(self, action: #selector(self.confirmAndSaveOrder), for: UIControlEvents.touchUpInside)
                return confirmButtonCell
            }
        }
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var heightForRow = CGFloat()
        // Food Menu
        if tableView == self.foodMenuTableView {
            heightForRow = 90
        }
        else if tableView == self.orderDetailTableView {
            //QuestionCell
            if indexPath.row == self.questionCellPosition {
                return 61
            }
                //FoodsCell
            else if indexPath.row <= self.rangeOfFoodEndPosition {
                return 98.5
            }
                //AnyObservation Cell
            else if indexPath.row == self.anyObservationCellPosition {
                return 168
            }
                //TotalPriceOrder Cell
            else if indexPath.row == self.totalPriceCelPosition {
                return 82
            }
                //ConfirmButtonCell
            else {
                return 51.5
            }
        }
        return heightForRow
    }
    
    //*************************************************
    // MARK: - Internal Methods
    //*************************************************
    
    private func showOrderDetails() {
        self.centerOrderDetail.constant = 17.5
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil )
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundOrderDetail.alpha = 0.5
            self.navigationController?.navigationBar.isHidden = true
        })
    }
    
    private func closeOrderDetails() {
        self.centerOrderDetail.constant = 700
        UIView.animate(withDuration: 0.3, animations: {
          self.view.layoutIfNeeded()
            self.backgroundOrderDetail.alpha = 0
            self.navigationController?.navigationBar.isHidden = false
        })
    }
    
    internal func hasSomeFood() {
        var quantity = Int()
        for food in self.receivedFoods {
            quantity = quantity + food.quantity!
        }
        if quantity != 0 {
            self.nextButton.isEnabled = true
        } else {
            self.nextButton.isEnabled = false
        }
    }
    
    internal func addFood(button: UIButton) {
        if let quantity = self.receivedFoods[button.tag].quantity {
            self.receivedFoods[button.tag].quantity = (quantity + 1)
        }
        self.hasSomeFood()
        self.foodMenuTableView.reloadData()
    }
    
    internal func removeFood(button: UIButton) {
        if let quantity = self.receivedFoods[button.tag].quantity {
            if quantity != 0 {
                self.receivedFoods[button.tag].quantity = (quantity - 1)
            } else {
                button.isEnabled = false
            }
        }
        self.hasSomeFood()
        self.foodMenuTableView.reloadData()
    }
    
    internal func confirmAndSaveOrder() {
        var myOrder = OrderVO(orderFromFood: self.foodsOfOrder)
        if self.observationOrder.isEmpty != true {
            myOrder.observation = self.observationOrder
        }
        if OrderManager.insertOrder(orderVO: myOrder) == .SUCCESS {
            self.closeOrderDetails()
            if let navControlle = self.navigationController {
                navControlle.popViewController(animated: true)
            }
        } else {
            self.failedInsertOrderAlert()
        }
    }
    
    //*************************************************
    // MARK: - Alert
    //*************************************************
    
    func failedInsertOrderAlert() {
        let alert = UIAlertController(title: "Error", message: "Not was posible request order!", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(tryAgainAction)
        self.present(alert, animated: true, completion: nil)
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
