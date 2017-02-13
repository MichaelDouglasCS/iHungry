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

typealias JSONDictionaryCompletion = (([String : Any]) -> Void)
typealias JSON = ([String : Any])

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
        //Authentication Stub
        stub(condition: isHost("ihungry.com") && isPath("/auth")) { request in
            // Stub it with our "auth.json" stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("auth.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
        //Food Menu Stub
        stub(condition: isHost("ihungry.com") && isPath("/menu")) { request in
            // Stub it with our "auth.json" stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("foodMenu.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func request(urlRequest: String, responseJSON: @escaping JSONDictionaryCompletion) {
        //Configuring request
        let url = URL(string: urlRequest)!
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        requestURL.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Executing Request
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, let receivedData = data
                else {
                    print("Error: Not a valid HTTP Response")
                    return
            }
            switch(httpResponse.statusCode) {
            case 200:
                do {
                    let parsedJSON = try JSONSerialization.jsonObject(with: receivedData, options: []) as! JSON
                    //Completion of JSON Parsed
                    print(parsedJSON)
                    responseJSON(parsedJSON)
                } catch let errorParse as NSError {
                    print(errorParse)
                }
                break
            default:
                print("Error: \(error)")
                break
            }
        }
        task.resume()
    }

//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
}
