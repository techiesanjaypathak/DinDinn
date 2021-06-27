//
//  Pizza.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

enum PizzaSection {
    case one
}

struct Pizza: Hashable, Decodable {
    
    var id:String = ""
    var name:String = ""
    var desc:String = ""
    var weight:Int = 0
    var dimension:Int = 0
    var price:Int = 0
    var image:String = ""
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
