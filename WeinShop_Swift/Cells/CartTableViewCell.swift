//
//  CartTableViewCell.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 03.11.22.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var tasteLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    @IBOutlet weak var btnRemoveItem: UIButton!
    @IBOutlet weak var btnAddItem: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
