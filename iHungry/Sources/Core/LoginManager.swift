//
//  LoginManager.swift
//  iHungry
//
//  Created by Michael Douglas on 17/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import Foundation
import KeychainSwift

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

private let keychain = KeychainSwift()
private let keyTokenName = "token"

//**************************************************************************************************
//
// MARK: - Class -
//
//**************************************************************************************************

class LoginManager {
    
    //*************************************************
    // MARK: - Properties
    //*************************************************
    
    static var token: String? {
        get { return keychain.get(keyTokenName) }
    }
    
    static var isLogged: Bool {
        get {
            if keychain.get(keyTokenName) != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    //*************************************************
    // MARK: - Public Methods
    //*************************************************
    
    class func authenticate(user: String, password: String, auth: @escaping ((ResponseMethod)->Void)) {
        let network = NetworkManager()
        network.request(urlRequest: URLs.authenticationURL()) { responseJSON in
            if let jsonAuth = responseJSON["auth"] as? NSDictionary,
                let passCredentials = jsonAuth["password-credentials"] as? NSDictionary {
                if ((user == passCredentials["username"] as? String) &&
                    ((password == passCredentials["password"] as? String))) {
                    if let token = passCredentials["token"] as? String {
                        keychain.set(token, forKey: keyTokenName)
                        auth(.SUCCESS)
                    } else {
                        print("Error: Could not get token")
                        auth(.FAILED)
                    }
                    
                } else {
                    auth(.FAILED)
                }
            } else {
                auth(.FAILED)
            }
        }
    }
    
    class func logout() {
        keychain.delete(keyTokenName)
    }
    
}
