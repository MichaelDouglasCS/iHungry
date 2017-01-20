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
// MARK: - Properties
//*************************************************

//*************************************************
// MARK: - Constructors
//*************************************************

//*************************************************
// MARK: - Public Methods
//*************************************************
    
    class func insertOrder(orderVO: OrderVO) {
        
        var id = Int()
        
        do {
            if let ordersArray = try CoreDataManager.context.fetch(Order.fetchRequest()) as? [Order] {
                if ordersArray.isEmpty != true {
                    id = ((Int((ordersArray.last?.id)!)!) + 1)
                } else {
                    id = 0
                }
            }
        } catch {
            print("Error: Could not posible insertOrder")
        }
        
        let order = Order(context: CoreDataManager.context)
        
        order.id = String(id)
        order.name = orderVO.name
        
        CoreDataManager.saveContext()
        
    }
    
    class func getAllOrders() -> [OrderVO] {

        var orderVO = [OrderVO]()
        
        do {
            if let ordersArray = try CoreDataManager.context.fetch(Order.fetchRequest()) as? [Order] {
                for order in ordersArray {
                    orderVO.append(OrderVO(order: order.getDictionary()))
                }
            }
        } catch {
            print("Erro: Not was posible getAllOrders")
        }
        return  orderVO
    }
    
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
            print("Erro: Not was posible DeleteOrders")
        }
    }

//*************************************************
// MARK: - Internal Methods
//*************************************************

//*************************************************
// MARK: - Self Public Methods
//*************************************************

}

//**************************************************************************************************
//
// MARK: - Extension - Dictionary
//
//**************************************************************************************************

extension NSManagedObject {
    
    func getDictionary() -> [String : Any] {
        var dictionary = [String : Any]()
        for key in self.entity.attributesByName.keys {
            let value = self.value(forKey: key)!
            dictionary.updateValue(value, forKey: key)
        }
        return dictionary
    }
    
}
