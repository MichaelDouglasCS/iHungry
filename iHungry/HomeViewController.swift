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

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

//*************************************************
// MARK: - IBOutlets
//*************************************************
    
    @IBOutlet weak var myOrdersTableView: UITableView!
    @IBOutlet weak var noOrdersView: UIView!
    
//*************************************************
// MARK: - Properties
//*************************************************
    
    //Variable that storages the Orders that appears in TableView
    private var orders = [OrderVO]()
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set NavigationBarTransparent
        self.setNavigationBarTransparent()
        //Verify if the user has been already logged in
        self.userIsLogged()
        //Remove UITableViewCell separator for empty cells
        self.myOrdersTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Update the Table View with MyOrders
        self.orders = OrderManager.getAllOrders()
        
        //Verify if ordes is empty to hidden noOrdersView
        if !(orders.isEmpty) {
            self.myOrdersTableView.isHidden = false
            self.noOrdersView.isHidden = true
        } else {
            self.myOrdersTableView.isHidden = true
            self.noOrdersView.isHidden = false
        }
        
        //ReloadData from My Orders Table View
        myOrdersTableView.reloadData()
        
    }
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
    //Verify if the user has been already logged in
    private func userIsLogged() {
        if !LoginManager.isLogged {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginView = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(loginView, animated: false, completion: nil)
        }
    }
    
//*************************************************
// MARK: - Internal Methods
//*************************************************
    
    private func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
//*************************************************
// MARK: - Table View Methods
//*************************************************
        
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("HomeCustomTableViewCell", owner: self, options: nil)?.first as! HomeCustomTableViewCell
        
        let orderCell = self.orders[indexPath.row]
        
        cell.orderName?.text = orderCell.name
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let orderCell = orders[indexPath.row]
            OrderManager.deleteOrder(orderVO: orderCell)
            self.orders = OrderManager.getAllOrders()
        }
        myOrdersTableView.reloadData()
        //Verify if ordes is empty to hidden noOrdersView
        if !(orders.isEmpty) {
            self.myOrdersTableView.isHidden = false
            self.noOrdersView.isHidden = true
        } else {
            self.myOrdersTableView.isHidden = true
            self.noOrdersView.isHidden = false
        }
    }
    
//*************************************************
// MARK: - IBActions
//*************************************************
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        LoginManager.logout()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginView, animated: true, completion: nil)
    }
}
