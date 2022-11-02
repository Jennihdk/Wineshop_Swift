//
//  CategoryViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var clickedCategory: String?
    
    func setCategory(tableViewController: WineSelectionTableViewController) {
        tableViewController.category = clickedCategory
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryListSegue" {
            if let destination = segue.destination as? WineSelectionTableViewController {
                destination.category = clickedCategory!
            }
                
        }
    }
    
    
    @IBAction func btnRedwineClicked(_ sender: UIButton) {
        clickedCategory = "rot"
        performSegue(withIdentifier: "CategoryListSegue", sender: self)
    }
    
    @IBAction func btnWhitewineClicked(_ sender: UIButton) {
        clickedCategory = "weiß"
        performSegue(withIdentifier: "CategoryListSegue", sender: self)
    }
    
    @IBAction func btnRosewineClicked(_ sender: UIButton) {
        clickedCategory = "rosé"
        performSegue(withIdentifier: "CategoryListSegue", sender: self)
    }

    
}
