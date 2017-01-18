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
    @IBOutlet weak var signInButton: UIButton!

    
//*************************************************
// MARK: - Override Public Methods
//*************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.signInButton.isEnabled = false
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
                    self.performSegue(withIdentifier: "homeViewSegue", sender: nil)
//                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                    let homeView = storyBoard.instantiateViewController(withIdentifier: "HomeNavigationViewController")
//                    self.present(homeView, animated: true, completion: nil)
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFill = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == self.userTextField {
            if ((!textFill.isEmpty) && (!(self.passwordTextField.text?.isEmpty)!)){
                signInButton.isEnabled = true
            } else {
                signInButton.isEnabled = false
            }
        }
        else if textField == self.passwordTextField {
            if ((!textFill.isEmpty) && (!(self.userTextField.text?.isEmpty)!)){
                signInButton.isEnabled = true
            } else {
                signInButton.isEnabled = false
            }
        }
        return true
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
    
//*************************************************
// MARK: - Self Alerts
//*************************************************
    
    func failedAuthAlert() {
        let alert = UIAlertController(title: "Authentication Failed", message: "Are you sure entered the right username and password?", preferredStyle: .alert)
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(tryAgainAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
