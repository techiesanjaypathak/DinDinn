//
//  PizzaService.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import Moya

enum PizzaService {
    case readPizza
}

extension PizzaService:TargetType {
    var baseURL: URL {
        URL(string: "https://60d55b69943aa600177688b9.mockapi.io/menuItems")!
    }
    
    var path: String {
        "pizzas"
    }
    
    var method: Moya.Method {
        .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        ["Content-Type":"application/json"]
    }
}
