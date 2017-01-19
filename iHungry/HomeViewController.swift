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
// MARK: - Properties
//*************************************************
    @IBOutlet weak var myOrdersTableView: UITableView!
    
    @IBOutlet weak var noOrderLine: UIImageView!
    @IBOutlet weak var noOrderLableTitle: UILabel!
    @IBOutlet weak var noOrderLabelDescription: UILabel!
    
    var orders: [OrderDB] = []
    
//*************************************************
// MARK: - Constructors
//*************************************************
    
//*************************************************
// MARK: - Override Public Methods
//*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBarTransparent()
        self.userIsLogged()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getData()
        
        if !(orders.isEmpty) {
            self.hideNoOrdersDescription(isHidden: true)
        } else {
            self.hideNoOrdersDescription(isHidden: false)
        }
        
        myOrdersTableView.reloadData()
    }
    
//*************************************************
// MARK: - Private Methods
//*************************************************
    
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
    
    func hideNoOrdersDescription(isHidden: Bool) {
        if isHidden == true {
            self.myOrdersTableView.isHidden = false
            self.noOrderLine.isHidden = true
            self.noOrderLableTitle.isHidden = true
            self.noOrderLabelDescription.isHidden = true
        } else {
            self.myOrdersTableView.isHidden = true
            self.noOrderLine.isHidden = false
            self.noOrderLableTitle.isHidden = false
            self.noOrderLabelDescription.isHidden = false
        }
    }
    
    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
//*************************************************
// MARK: - Scroll View Methods
//*************************************************
    
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
        orders = try context.fetch(OrderDB.fetchRequest())
        } catch {
            print("Deu ruim")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let order = orders[indexPath.row]
        
        cell.textLabel?.text = order.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let order = orders[indexPath.row]
            context.delete(order)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                orders = try context.fetch(OrderDB.fetchRequest())
            } catch {
                print("Deu ruim")
            }
        }
        myOrdersTableView.reloadData()
        
        if !(orders.isEmpty) {
            self.hideNoOrdersDescription(isHidden: true)
        } else {
            self.hideNoOrdersDescription(isHidden: false)
        }
    }
    
//*************************************************
// MARK: - Self Public Methods
//*************************************************
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        LoginManager.logout()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginView = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(loginView, animated: true, completion: nil)
    }
}
