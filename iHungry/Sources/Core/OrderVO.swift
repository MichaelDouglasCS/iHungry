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
    var observation: String?
    var orderPrice: Double?
    var foods: [FoodVO]?
    
    
    //*************************************************
    // MARK: - Constructors
    //*************************************************
    
    init() {
        
    }
    
    init(orderFromObject: JSONDictionary) {
        self.id = orderFromObject["id"] as? String
        self.name = orderFromObject["name"] as? String
        self.image = orderFromObject["image"] as? String
        self.observation = orderFromObject["observation"] as? String
        self.foods = [FoodVO]()
        self.orderPrice = orderFromObject["orderPrice"] as? Double
    }
    
    init(orderFromFood: [FoodVO]) {
        self.name = orderFromFood[0].name
        self.image = orderFromFood[0].image
        self.foods = orderFromFood
        self.orderPrice = self.calculateOrderPrice(foods: orderFromFood)
    }
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    private func calculateOrderPrice(foods: [FoodVO]) -> Double {
        var result = Double()
        for food in foods {
            if let quantity = food.quantity {
                if let price = food.price {
                    result = (result + (price * Double(quantity)))
                }
            }
        }
        return result
    }
    
    //*************************************************
    // MARK: - Static Methods
    //*************************************************
 
    static func getOrderPrice(foods: [FoodVO]) -> Double? {
        var result = Double()
        for food in foods {
            if let quantity = food.quantity {
                if let price = food.price {
                    result = (result + (price * Double(quantity)))
                }
            }
        }
        return result
    }
    
}
