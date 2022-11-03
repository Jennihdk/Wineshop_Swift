//
//  SearchTableViewCell.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 02.11.22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tasteLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
