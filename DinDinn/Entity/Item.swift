//
//  Item.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import Foundation

import RealmSwift

enum ItemSection {
    case one
}

class Item:Object {

    @objc dynamic var itemId:String = ""
    @objc dynamic var name:String = ""
    @objc dynamic var desc:String = ""
    @objc dynamic var weight:Int = 0
    @objc dynamic var dimension:Int = 0
    @objc dynamic var quantity:Int = 0
    @objc dynamic var volume:Int = 0
    @objc dynamic var pieces:Int = 0
    @objc dynamic var price:Int = 0
    @objc dynamic var image:String = ""
    @objc dynamic var type:String = ""
    
    override class func primaryKey() -> String? {
        return "itemId"
    }
}

extension Item {
    static func getItem(from itemInfo:ItemInfo) -> Item {
        let item = Item()
        item.itemId = itemInfo.id
        item.name = itemInfo.name
        item.desc = itemInfo.desc
        item.weight = 10
        item.dimension = 10
        item.price = itemInfo.price
        
        item.volume = itemInfo.volume
        item.weight = itemInfo.weight
        item.pieces = itemInfo.pieces
        item.dimension = itemInfo.dimension
        
        item.image = itemInfo.imageURL.absoluteString
        item.type = itemInfo.type
        item.quantity = 1
        return item
    }
}
