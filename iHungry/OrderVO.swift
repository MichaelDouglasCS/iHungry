//
//  OrderVO.swift
//  iHungry
//
//  Created by Michael Douglas on 18/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import Foundation

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

typealias OrderDictionary = [String : Any]

//**************************************************************************************************
//
// MARK: - Struct -
//
//**************************************************************************************************

struct OrderVO {

//*************************************************
// MARK: - Properties
//*************************************************
    
    var id: String?
    var name: String?
    var image: String?
    var foods: [FoodVO]?
    var orderPrice: Double?

//*************************************************
// MARK: - Constructors
//*************************************************
    
    init() {
        
    }
    
    init(order: OrderDictionary) {
        self.id = order["id"] as? String
        self.name = order["name"] as? String
        self.image = order["image"] as? String
        self.foods = order["foods"] as? [FoodVO]
        self.orderPrice = order["orderPrice"] as? Double
    }
    
    init(foodOrder: [FoodVO]) {
        self.name = foodOrder[0].name
        self.image = foodOrder[0].image
        self.foods = foodOrder
        self.orderPrice = self.calculateOrderPrice(foods: foodOrder)
    }

//*************************************************
// MARK: - Private Methods
//*************************************************
    
    private func calculateOrderPrice(foods: [FoodVO]) -> Double {
        var result = Double()
        for food in foods {
            if let price = food.price {
                result = (result + price)
            }
        }
        return result
    }

//*************************************************
// MARK: - Internal Methods
//*************************************************
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

//*************************************************
// MARK: - Override Public Methods
//*************************************************

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

}
