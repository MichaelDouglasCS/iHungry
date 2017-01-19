//
//  HomeViewController.swift
//  iHungry
//
//  Created by Michael Douglas on 17/01/17.
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

class HomeViewController: UIViewController {
    
//*************************************************
// MARK: - Properties
//*************************************************
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTransparent()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginView, animated: false, completion: nil)
    }
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginView, animated: true, completion: nil)
    }
}
