//
//  WineSelectionTableViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class WineSelectionTableViewController: UITableViewController {
    
    var apiClient = APIClient()
    var wineList = [Wine]()
    var category: String!
    var wineListByCategory: [Wine]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiClient.getWineList { wine in
            for w in wine {
                //self.wineList = wine
                if w.category == self.category {
                    self.wineList.append(w)
                }
            }
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            guard let destination = segue.destination as? WineDetailsViewController else { return }
            guard let wine = sender as? Wine else { return }
            destination.wineImage = wine.productImg
            destination.wineName = wine.productName
            destination.wineYear = Int(wine.year!)
            destination.wineTaste = wine.taste
            destination.winePrice = wine.price
            destination.wineDescription = wine.description
            }
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wineList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WineCell", for: indexPath) as! WineSelectionTableViewCell
        
        // Configure the cell
        let wine = wineList[indexPath.row]
        cell.nameLbl.text = wine.productName
        cell.yearLbl.text = wine.year?.description
        cell.tasteLbl.text = wine.taste
        cell.priceLbl.text = String(format: "%.2f", wine.price!)
                
        guard let url = URL(string: wine.productImg!) else { return cell }
        self.apiClient.getImage(imageUrl: url){ image in
            DispatchQueue.main.async {
                cell.productImgView.image = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedWine = wineList[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: selectedWine)
    }
}
