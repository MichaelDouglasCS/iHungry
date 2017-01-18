//
//  NetworkManager.swift
//  iHungry
//
//  Created by Michael Douglas on 17/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import Foundation
import OHHTTPStubs

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

typealias JSONDictionary = (([String:Any]) -> Void)

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class NetworkManager {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
    init() {
        stub(condition: isHost("ihungry.com")) { request in
            // Stub it with our "auth.json" stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("auth.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func request(urlRequest: String, parameters: [String: String], responseJSON: JSONDictionary) {
        //Configuring request
        let url = URL(string: urlRequest)!
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Executing Request
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else{
                    print("Error: Not a valid HTTP Response")
                    return
            }
            
            switch(httpResponse.statusCode) {
            case 200:
                       
                
                print(String(data: receivedData, encoding: .utf8)!)
                break
                
            default:
                
                break
            }
            
        }
        
        task.resume()
        
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
}
