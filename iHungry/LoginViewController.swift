//
//  LoginViewController.swift
//  iHungry
//
//  Created by Michael Douglas on 15/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import UIKit
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

class LoginViewController: UIViewController, UITextFieldDelegate {

//*************************************************
// MARK: - Properties
//*************************************************
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    @IBAction func signIn(_ button: RoundedButton) {
        LoginManager.authenticate(user: self.userTextField.text!, password: self.passwordTextField.text!) { authStatus in
            switch(authStatus) {
            case .SUCCESS:
                DispatchQueue.main.async {
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
                    self.present(homeView, animated: true, completion: nil)
                }
                break
            case .FAILED:
                DispatchQueue.main.async {
                    self.failedAuthAlert()
                }
                break
            }
        }
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************
    
    func failedAuthAlert() {
        let alert = UIAlertController(title: "Authentication Failed", message: "Are you sure entered the right username and password?", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(tryAgainAction)
        self.present(alert, animated: true, completion: nil)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == userTextField || textField == passwordTextField) {
            scrollView.setContentOffset(CGPoint.init(x: 0, y: 100), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
