//
//  Drink.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

enum DrinkSection {
    case one
}

struct Drink:Hashable, Decodable {

    var id:String = ""
    var name:String = ""
    var desc:String = ""
    var volume:Int = 0
    var bottles:Int = 0
    var price:Int = 0
    var image:String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
