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
                let order = Order(context: CoreDataManager.context)
                
                order.id = String(id)
                order.name = orderVO.name
                
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
                for order in ordersFetched {
                    resultOrders.append(OrderVO(order: order.getDictionary()))
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
    func getDictionary() -> [String : Any] {
        var dictionary = [String : Any]()
        for key in self.entity.attributesByName.keys {
            let value = self.value(forKey: key)!
            dictionary.updateValue(value, forKey: key)
        }
        return dictionary
    }
}
