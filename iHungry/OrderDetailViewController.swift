//
//  OrderDetailViewController.swift
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

class OrderDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //*************************************************
    // MARK: - IBOutlet
    //*************************************************
    
    @IBOutlet weak var orderDetailsTableView: UITableView!
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    var order = OrderVO()
    private var foodsOfOrder = [FoodVO]()
    
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
    
    //*************************************************
    // MARK: - Override Public Methods
    //*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        if let observation = self.order.observation {
            print(observation)
        }
        if let foods = self.order.foods {
            self.foodsOfOrder = foods
        }
        //Remove UITableViewCell separator for empty cells
        self.orderDetailsTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //*************************************************
    // MARK: - Table View Methods
    //*************************************************
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.foodsOfOrder.count + 3)
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Verify indexPath.row to format Table View accornding to design
        //QuestionCell
        if indexPath.row == self.questionCellPosition {
            let questionConfirmCell = Bundle.main.loadNibNamed("QuestionConfirmOrderCell", owner: self, options: nil)?.first as! QuestionConfirmOrderCell
            questionConfirmCell.questionConfirmOrder.text = "Your order has been submitted!"
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
            if let totalPrice = self.foodsOfOrder[positionCell].getTotalPrice() {
                confirmFoodsCell.foodPrice.text = totalPrice.toReal()
            }
            if let quantity = self.foodsOfOrder[positionCell].quantity {
                confirmFoodsCell.foodQuantity.text = quantity.toString()
            }
            return confirmFoodsCell
        }
            //AnyObservation Cell
        else if (indexPath.row == self.anyObservationCellPosition) {
            let anyObservationCell = Bundle.main.loadNibNamed("AnyObservationCell", owner: self, options: nil)?.first as! AnyObservationCell
            anyObservationCell.tag = self.anyObservationCellPosition
            anyObservationCell.observationLabel.text = "Observations:"
            anyObservationCell.observationTextView.isEditable = false
            anyObservationCell.observationTextView.text = self.order.observation
            return anyObservationCell
        }
            //TotalPriceOrder Cell
        else {
            let totalPriceOrderCell = Bundle.main.loadNibNamed("TotalPriceOrderCell", owner: self, options: nil)?.first as! TotalPriceOrderCell
            
            if let totalPriceOrder = OrderVO.getOrderPrice(foods: self.foodsOfOrder) {
                totalPriceOrderCell.foodPriceTotal.text = totalPriceOrder.toReal()
            }
            return totalPriceOrderCell
        }
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //Verify indexPath.row to format Table View accornding to design
        //QuestionCell
        if indexPath.row == self.questionCellPosition {
            return 61
        }
            //FoodsCell
        else if indexPath.row <= self.rangeOfFoodEndPosition {
            return 98.5
        }
            //AnyObservation Cell
        else if (indexPath.row == self.anyObservationCellPosition) {
            return 168
        }
            //TotalPriceOrder Cell
        else {
            return 82
        }
    }
    
    //*************************************************
    // MARK: - IBActions
    //*************************************************
    
    @IBAction func cancelConfirmation(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
