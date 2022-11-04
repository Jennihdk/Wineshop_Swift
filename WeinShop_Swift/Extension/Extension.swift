//
//  Extension.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 02.11.22.
//

import Foundation
import UIKit

//MARK: - SearchTableView
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults == nil {
            return 0
        } else {
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchTableViewCell
    
        let result = searchResults[indexPath.row]
        cell.nameLbl.text = result.productName
        cell.tasteLbl.text = result.taste
        cell.priceLbl.text = String(format: "%.2f", result.price!)
        
        guard let url = URL(string: result.productImg!) else { return cell }
        self.apiClient.getImage(imageUrl: url){ image in
            DispatchQueue.main.async {
                cell.imgView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        performSegue(withIdentifier: "SearchResultSegue", sender: selectedResult)
    }
}

//MARK: - SearchBar
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchResults = []
        
        if searchText == "" {
            searchResults = wineList
        } else {
            for wine in wineList {
                print(wine.productName)
                if wine.productName!.lowercased().contains(searchText.lowercased()) {
                    searchResults.append(wine)
                }
            }
        }
        tableView.reloadData()
    }
}

//MARK: - CartTableView
/*extension CartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}*/
