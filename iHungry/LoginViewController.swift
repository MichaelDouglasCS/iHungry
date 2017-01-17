//
//  LoginViewController.swift
//  iHungry
//
//  Created by Michael Douglas on 15/01/17.
//  Copyright © 2017 Michael Douglas. All rights reserved.
//

import UIKit

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
    
    @IBAction func signIn(_ sender: RoundedButton) {
        
    }

    
//*************************************************
// MARK: - Self Public Methods
//*************************************************

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

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

