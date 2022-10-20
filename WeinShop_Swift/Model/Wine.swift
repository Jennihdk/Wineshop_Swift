//
//  Wine.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 18.10.22.
//

import Foundation

struct Wine: Codable {
    var productImg: String?
    var productName: String?
    var year: Int?
    var taste: String?
    var price: Float?
    var category: String?
    var description: String?
}
