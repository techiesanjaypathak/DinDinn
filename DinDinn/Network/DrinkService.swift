//
//  DrinkService.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import Moya

enum DrinkService {
    case readDrink
}
extension DrinkService:TargetType {
    var baseURL: URL {
        URL(string: "https://60d55b69943aa600177688b9.mockapi.io/menuItems")!
    }
    
    var path: String {
        "drinks"
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
