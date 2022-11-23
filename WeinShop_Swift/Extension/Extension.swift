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
        cell.priceLbl.text = String(format: "%.2f €", result.price!)
        
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
                if wine.productName!.lowercased().contains(searchText.lowercased()) {
                    searchResults.append(wine)
                }
            }
        }
        tableView.reloadData()
    }
}

//MARK: - CartTableView
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartItems == nil {
            return 0
        } else {
            return cartItems!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        let item = cartItems![indexPath.row]
        cell.imgView.image = UIImage(data: item.image!)
        cell.nameLbl.text = item.name
        cell.tasteLbl.text = item.taste
        cell.yearLbl.text = item.year.description
        cell.priceLbl.text = String(format: "%.2f €", item.singlePrice)
        cell.quantityLbl.text = item.quantity.description
        
        cell.btnDeleteItem.tag = indexPath.row
        cell.btnDeleteItem.addTarget(self, action: #selector(deleteItem(_ :)), for: .touchUpInside)
        cell.btnAddItem.tag = indexPath.row
        cell.btnAddItem.addTarget(self, action: #selector(increase(_ :)), for: .touchUpInside)
        cell.btnRemoveItem.tag = indexPath.row
        cell.btnRemoveItem.addTarget(self, action: #selector(decrease(_ :)), for: .touchUpInside)
    
        return cell
    }
    
    //Delete items from the shopping cart
    @objc func deleteItem(_ sender: UIButton){
        let alert = UIAlertController(title: "Artikel löschen", message: "Möchtest du den Artikel wirklich aus dem Warenkorb entfernen", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel)
        let acceptAction = UIAlertAction(title: "Löschen", style: .default, handler: { [self] (_) in
            let itemToDelete = cartItems![sender.tag]
            context.delete(itemToDelete)
            saveCurrentCart()
            fetchWine()
            tableView.deleteRows(at: [IndexPath(row: sender.tag, section:0)], with: .none)
            totalPrice()
        })
        alert.addAction(cancelAction)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
    
    //Increase the number of items in the shopping cart
    @objc func increase(_ sender: UIButton) {
        let itemToIncrease = cartItems![sender.tag]
        itemToIncrease.quantity += 1
        totalPrice()
        saveCurrentCart()
        tableView.reloadData()
    }
    
    //Reduce the number of items in the shopping cart
    @objc func decrease(_ sender: UIButton) {
        let itemToDecrease = cartItems![sender.tag]
        if itemToDecrease.quantity > 1 {
            itemToDecrease.quantity -= 1
        } else {
            let alert = UIAlertController(title: "Artikel löschen", message: "Möchtest du den Artikel wirklich aus dem Warenkorb entfernen", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel)
            let acceptAction = UIAlertAction(title: "Löschen", style: .default, handler: { [self] (_) in
                context.delete(itemToDecrease)
                fetchWine()
                tableView.deleteRows(at: [IndexPath(row: sender.tag, section:0)], with: .none)
                totalPrice()
            })
            alert.addAction(cancelAction)
            alert.addAction(acceptAction)
            present(alert, animated: true)
            
        } 
        totalPrice()
        saveCurrentCart()
        tableView.reloadData()
    }
}


