//
//  WineDetailsViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit
import CoreData

class WineDetailsViewController: UIViewController {
    
    //MARK: - Variables and Outlets
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailYear: UILabel!
    @IBOutlet weak var detailTaste: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    //Variables for DetailView
    var wineImage: String?
    var wineName: String?
    var wineYear: Int?
    var wineTaste: String?
    var winePrice: Float?
    var wineDescription: String?
    
    //
    var cart = CartViewController()
    
    //CoreData
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //API
    var apiClient = APIClient()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailName.text = wineName
        detailYear.text = wineYear?.description
        detailTaste.text = wineTaste
        detailPrice.text = String(format: "%.2f €", winePrice!)
        detailDescription.text = wineDescription
        
        guard let url = URL(string: wineImage!) else { return }
        apiClient.getImage(imageUrl: url) { image in
            DispatchQueue.main.async {
                self.detailImage.image = image
            }
        }
    }
    
    //MARK: - Functions
    func updateCart() {
        /*This function checks whether an item is already in the shopping cart. This is recognized with the name of the item
         *If the item is in the shopping cart, the number increases.
         *Otherwise a new article will be added
        */
        let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", detailName.text!)
        
        do {
            let cartList = try context.fetch(fetchRequest)
            if cartList.count > 0 {
                let cartItem = cartList.first
                cartItem!.quantity += 1
            } else {
                let cartItem = CartItem(context: context)
                let image: UIImage = detailImage.image!
                let cartImage = image.jpegData(compressionQuality: 1.0)
                cartItem.image = cartImage
                cartItem.name = detailName.text
                cartItem.taste = detailTaste.text
                cartItem.year = Int16(detailYear.text!)!
                
                //removes the euro sign to convert to a float
                let eurozeichen = detailPrice.text!.replacingOccurrences(of: " €", with: "")
                cartItem.singlePrice = Float(eurozeichen)!
                
                cartItem.quantity = 1
            }
            do {
                try context.save()
            } catch {
                print("Saving context failed")
            }
        } catch {
            print("Could not fetch cart")
        }
    }
    
    
    //MARK: - Actions
    @IBAction func btnAddToCart(_ sender: UIButton) {
        updateCart()
    }
}
