//
//  CartViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit
import CoreData
import FirebaseAuth
import FirebaseFirestore

class CartViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    
    var cartItems: [CartItem]?
    
    //CoreData & fetchResult
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //API
    let apiClient = APIClient()
    
    //Firebase
    let db = Firestore.firestore()

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK: - viewDidAppear
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
        if cartItems?.count != nil {
            performSegue(withIdentifier: "CashSegue", sender: nil)
        } else {
            let alert = UIAlertController(title: "Warenkorb", message: "Dein Warenkorb ist leer", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        
    }
    
}
