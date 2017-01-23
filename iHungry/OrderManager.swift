//
//  OrderManager.swift
//  iHungry
//
//  Created by Michael Douglas on 18/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import Foundation
import CoreData

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

class OrderManager {
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    // MARK - Insert Order
    class func insertOrder(orderVO: OrderVO) {
        do {
            if let ordersArray = try CoreDataManager.context.fetch(Order.fetchRequest()) as? [Order] {
                var id: Int {
                    get{
                        if ordersArray.isEmpty != true {
                            return ((Int((ordersArray.last?.id)!)!) + 1)
                        } else {
                            return 0
                        }
                    }
                }
                
                let orderObject = Order(context: CoreDataManager.context)
                orderObject.id = String(id)
                orderObject.name = orderVO.name
                orderObject.image = orderVO.image
                if let price = orderVO.orderPrice{
                    orderObject.orderPrice = price
                }
                if let foods = orderVO.foods {
                    for food in foods {
                        orderObject.addToFoods(food.toObject())
                    }
                }
                CoreDataManager.saveContext()
            }
        } catch {
            print("Error: Could not posible Insert Order")
        }
    }
    
    // MARK - Get All Orders
    class func getAllOrders() -> [OrderVO] {
        var resultOrders = [OrderVO]()
        do {
            if let ordersFetched = try CoreDataManager.context.fetch(Order.fetchRequest()) as? [Order] {
                for orderObject in ordersFetched {
                    var orderResult = OrderVO(orderFromObject: orderObject.getDictionary())
                    for food in ((orderObject.foods?.allObjects)! as? [Food])!{
                        orderResult.foods?.append(FoodVO(foodFromObject: food.getDictionary()))
                    }
                  resultOrders.append(orderResult)
                }
            }
        } catch {
            print("Erro: Not was posible Get All Orders")
        }
        return  resultOrders
    }
    
    // MARK - Delete Order
    class func deleteOrder(orderVO: OrderVO) {
        do {
            if let ordersArray = try CoreDataManager.context.fetch(Order.fetchRequest()) as? [Order] {
                for order in ordersArray {
                    if (order.id == orderVO.id) {
                        CoreDataManager.context.delete(order)
                    }
                }
            }
        } catch {
            print("Erro: Not was posible Delete Orders")
        }
    }
}

//**************************************************************************************************
//
// MARK: - Extension - NSManagedObject
//
//**************************************************************************************************

extension NSManagedObject {
    //Convert NSManagedObject into Dictionary
    func getDictionary() -> OrderDictionary {
        var dictionary = [String : Any]()
        for key in self.entity.attributesByName.keys {
            if let value = self.value(forKey: key) {
                dictionary.updateValue(value, forKey: key)
            }
        }
        return dictionary
    }
}

extension FoodVO {
    func toObject() -> Food {
        let foodManagedObject = Food(context: CoreDataManager.context)
        foodManagedObject.category = self.category
        foodManagedObject.image = self.image
        foodManagedObject.name = self.name
        if let price = self.price {
            foodManagedObject.price = price
        }
        if let quantity = self.quantity {
        foodManagedObject.quantity = Int16(quantity)
        }
        return foodManagedObject
    }
}
