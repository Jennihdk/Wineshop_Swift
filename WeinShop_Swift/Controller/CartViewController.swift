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
    
    var cartItems: [CartItem]!
    var selectedItem: Wine?
    
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
    
    //MARK: - Actions
    @IBAction func btnBuyClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "BoughtSegue", sender: nil)
    }
}
