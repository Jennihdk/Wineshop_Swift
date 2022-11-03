//
//  SearchViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class SearchViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var wineList: [Wine]!
    var searchResults: [Wine]!
    var apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        apiClient.getWineList { wine in
            self.wineList = wine
            self.searchResults = self.wineList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchResultSegue" {
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
}
