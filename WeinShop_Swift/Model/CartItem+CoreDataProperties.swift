//
//  CartItem+CoreDataProperties.swift
//  WeinShop_Swift
//
//  Created by Jennifer Hedtke on 08.11.22.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var singlePrice: Float
    @NSManaged public var taste: String?
    @NSManaged public var totalPrice: Float
    @NSManaged public var year: Int16
    @NSManaged public var inCart: Bool

}

extension CartItem : Identifiable {

}
