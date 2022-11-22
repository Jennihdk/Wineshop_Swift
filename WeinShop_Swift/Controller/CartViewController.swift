//
//  CartViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit
import CoreData

class CartViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var cartItems: [CartItem]?
    
    //CoreData & fetchResult
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //API
    let apiClient = APIClient()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchWine()
        totalPrice()
    }
    
    //MARK: - Functions
    func totalPrice(){
        var totalprice: Float = 0.0
        for i in cartItems! {
            let price = Float(i.singlePrice)
            let quantity = Float(i.quantity)
            totalprice += price * quantity
        }
        totalPriceLbl.text = String(format: "%.2f €", totalprice)
    }
    
    //CoreData Functions
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
    
    //MARK: - Actions
    @IBAction func btnCheckOutClicked(_ sender: UIButton) {
        
    }
}
