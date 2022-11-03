//
//  WineDetailsViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class WineDetailsViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailYear: UILabel!
    @IBOutlet weak var detailTaste: UILabel!
    @IBOutlet weak var detailPrice: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    var wineImage: String?
    var wineName: String?
    var wineYear: Int?
    var wineTaste: String?
    var winePrice: Float?
    var wineDescription: String?
    
    var apiClient = APIClient()
    
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
}
