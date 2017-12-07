//
//  FoodMenuManager.swift
//  iHungry
//
//  Created by Michael Douglas on 21/01/17.
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
// MARK: - Class -
//
//**************************************************************************************************

class FoodMenuManager {

//*************************************************
// MARK: - Public Methods
//*************************************************
    
    class func getMenu(foods: @escaping (([FoodVO]) -> Void)) {
        var foodArray = [FoodVO]()
        let network = NetworkManager()
        network.request(urlRequest: URLs.menuURL()) { responseJSON in
            if let jsonMenu = responseJSON["food-menu"] as? NSDictionary,
                let jsonFoods = jsonMenu["foods"] as? [NSDictionary]{
                for food in jsonFoods {
                    foodArray.append(FoodVO(foodFromJSON: food as! JSONDictionary))
                }
                foods(foodArray)
            }
        }
    }

}
