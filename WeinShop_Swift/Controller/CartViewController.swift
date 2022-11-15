//
//  CartViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var cartItems: [CartItem]!
    var cartItem = CartItem()
    
    //CoreData Context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //API
    let apiClient = APIClient()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(addCartItem(_ :)), name: NSNotification.Name.init("de.cartItemToCart"), object: nil)
        
        fetchWine()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(cartItems)
    }
    
    //MARK: - Functions
    
    //CoreData
    func fetchWine() {
        do {
            self.cartItems = try context.fetch(CartItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error by trying fetch request")
        }
    }
    
    func saveCurrentCart() {
        do {
            try context.save()
        } catch {
            print("Saving context failed")
        }
    }
    
    //Pass Data
    @objc func addCartItem(_ notification: NSNotification) {
        guard let iteminCart = notification.object as? CartItem else { return }
        
        if iteminCart.inCart == true {
            iteminCart.quantity += 1
            print("Item alredy exists in cart")
        } else {
            print("Item doesnt exists in cart")
        }
        saveCurrentCart()
        tableView.reloadData()
        
    }
    
    //MARK: - Actions
    @IBAction func btnBuyClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "BoughtSegue", sender: nil)
    }
}
