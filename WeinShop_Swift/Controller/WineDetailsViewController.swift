//
//  WineDetailsViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

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
        detailPrice.text = String(format: "%.2f", winePrice!)
        detailDescription.text = wineDescription
        
        guard let url = URL(string: wineImage!) else { return }
        apiClient.getImage(imageUrl: url) { image in
            DispatchQueue.main.async {
                self.detailImage.image = image
            }
        }
    }
    
    //MARK: - Functions
    
    
    //MARK: - Actions
    @IBAction func btnAddToCart(_ sender: UIButton) {
        
        let cartItem = CartItem(context: context)
        let vc = CartViewController()
        if cartItem.inCart == true {
            print("Cartitem already in cart")
            cartItem.quantity += 1
            context.saveIfChanged()
            
        } else {
            let image: UIImage = detailImage.image!
            let cartImage = image.jpegData(compressionQuality: 1.0)
            cartItem.image = cartImage
            cartItem.name = detailName.text
            cartItem.taste = detailTaste.text
            cartItem.year = Int16(detailYear.text!)!
            cartItem.singlePrice = Float(detailPrice.text!)!
            cartItem.quantity += 1
            cartItem.inCart = true
            do {
                try context.save()
            } catch {
                print("Saving context failed")
            }
           // NotificationCenter.default.post(name: NSNotification.Name.init("de.cartItemToCart"), object: cartItem)
            
            print("Cartitem does not contain cartitem")
        }
        
        
        
    }
}
