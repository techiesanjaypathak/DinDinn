//
//  ProductInteractor.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import Moya

class ProductInteractor {
    weak var output:ProductInteractorOutput?
    var apiDataManager = APIDataManager()
    var localDataManager = RealmHelper.shared.defaultRealm
    
    var pizzasProvider = MoyaProvider<PizzaService>()
    var sushisProvider = MoyaProvider<SushiService>()
    var drinksProvider = MoyaProvider<DrinkService>()
}

extension ProductInteractor : ProductUseCase {
    func fetchPizzas(){
        pizzasProvider.request(.readPizza) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let pizzas = try? JSONDecoder().decode([Pizza].self, from: response.data) else { return }
                self?.output?.applySnapshotForPizzas(for: pizzas)
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
    
    func fetchSushis(){
        sushisProvider.request(.readSushi) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let sushis = try? JSONDecoder().decode([Sushi].self, from: response.data) else { return }
                self?.output?.applySnapshotForSushis(for: sushis)
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
    
    func fetchDrinks(){
        drinksProvider.request(.readDrink) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let drinks = try? JSONDecoder().decode([Drink].self, from: response.data) else { return }
                self?.output?.applySnapshotForDrinks(for: drinks)
            case .failure(let error):
                debugPrint(error)
                break
            }
        }
    }
}
