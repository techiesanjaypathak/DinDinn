//
//  ItemInfo.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation

struct ItemInfo {
    let id:String
    let name:String
    let desc:String
    let volume:Int
    let weight:Int
    let pieces:Int
    let dimension:Int
    let bottles:Int
    let price:Int
    let imageURL:URL
    let type:String
}

extension ItemInfo {
    static func getItemInfo(from drink:Drink) -> ItemInfo {
        return ItemInfo(id:"Drink\(drink.id)",
                        name: drink.name,
                        desc: drink.desc,
                        volume: drink.volume,
                        weight: 0,
                        pieces: 0,
                        dimension: 0,
                        bottles: drink.bottles,
                        price: drink.price,
                        imageURL: URL(string: drink.image+"/drink\(drink.id)")!,
                        type: "Drink")
    }
    static func getItemInfo(from sushi:Sushi) -> ItemInfo {
        return ItemInfo(id:"Sushi\(sushi.id)",
                        name: sushi.name,
                        desc: sushi.desc,
                        volume: 0,
                        weight: sushi.weight,
                        pieces: sushi.pieces,
                        dimension:0,
                        bottles: 0,
                        price: sushi.price,
                        imageURL: URL(string: sushi.image+"/sushi\(sushi.id)")!,
                        type: "Sushi")
    }
    static func getItemInfo(from pizza:Pizza) -> ItemInfo {
        return ItemInfo(id:"Pizza\(pizza.id)",
                        name: pizza.name,
                        desc: pizza.desc,
                        volume: 0,
                        weight:pizza.weight,
                        pieces:0,
                        dimension:pizza.dimension,
                        bottles: 0,
                        price:pizza.price,
                        imageURL: URL(string: pizza.image+"/pizza\(pizza.id)")!,
                        type: "Pizza")
    }
}
