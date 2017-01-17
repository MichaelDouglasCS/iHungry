//
//  URL.swift
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

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

public class URL {
    
    //*************************************************
    // MARK: - Enum
    //*************************************************
    
    let stub = OHHTTPStubs()
    
    func teste() {
        // Swift
        stub(isHost("mywebservice.com")) { request in
            // Stub it with our "wsresponse.json" stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("wsresponse.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
    enum BaseURL: String {
        case MockServer = "https://private-anon-b6b620dfc0-ibmfc.apiary-mock.com"
    }
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    static let host = BaseURL.MockServer
    
    //*************************************************
    // MARK: - Constructors
    //*************************************************
    
    //*************************************************
    // MARK: - Private Methods
    //*************************************************
    
    //*************************************************
    // MARK: - Internal Methods
    //*************************************************
    
    public class func hostURL() -> String {
        return self.host.rawValue
    }
    
    public class func authenticationURL() -> String {
        return URL.BaseURL.MockServer.rawValue + "/login"
    }
    
    public class func getAllGames() -> String {
        return URL.BaseURL.MockServer.rawValue + "/games"
    }
    
    public class func getAllStrikers() -> String {
        return URL.BaseURL.MockServer.rawValue + "/strikers"
    }
    
}
