//
//  CategoryViewController.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 17.10.22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    //MARK: - Variables & Outlets
    @IBOutlet weak var btnRedwine: UIButton!
    @IBOutlet weak var btnWhitewine: UIButton!
    @IBOutlet weak var btnRosewine: UIButton!
    
    var clickedCategory: String?
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTextStyle()
    }
    
    //MARK: - Functions
    func btnTextStyle() {
        btnRedwine.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        btnWhitewine.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
        btnRosewine.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28)
    }
    
    func setCategory(tableViewController: WineSelectionTableViewController) {
        tableViewController.category = clickedCategory
    }
    
    //MARK: - Navigation and pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoryListSegue" {
            if let destination = segue.destination as? WineSelectionTableViewController {
                destination.category = clickedCategory!
            }
        }
    }
    
    //MARK: - Actions
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
