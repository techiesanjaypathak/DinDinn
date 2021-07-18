//
//  ProductInteractor.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import Moya
import Combine

class ProductInteractor {
    weak var output:ProductInteractorOutput?
    var apiDataManager = APIDataManager()
    var localDataManager = RealmHelper.shared.defaultRealm
    
    var pizzasProvider = MoyaProvider<PizzaService>()
    var sushisProvider = MoyaProvider<SushiService>()
    var drinksProvider = MoyaProvider<DrinkService>()
    
    var pizzaToken : AnyCancellable?
    var sushiToken : AnyCancellable?
    var drinkToken : AnyCancellable?
}

extension ProductInteractor : ProductUseCase {
    func fetchPizzas(){
        pizzasProvider.request(.readPizza) { [weak self] (result) in
            self?.pizzaToken = result.publisher.eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .map { $0.data }
                .decode(type: [Pizza].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    debugPrint("Handle Error")
                }
            }, receiveValue: { (pizzas) in
                self?.output?.applySnapshotForPizzas(for: pizzas)
            })
        }
    }
    
    func fetchSushis(){
        sushisProvider.request(.readSushi) { [weak self] (result) in
            self?.sushiToken = result.publisher.eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .map { $0.data }
                .decode(type: [Sushi].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    debugPrint("Handle Error")
                }
            }, receiveValue: { (sushis) in
                self?.output?.applySnapshotForSushis(for: sushis)
            })
        }
    }
    
    func fetchDrinks(){
        drinksProvider.request(.readDrink) { [weak self] (result) in
            self?.drinkToken = result.publisher.eraseToAnyPublisher()
                .receive(on: RunLoop.main)
                .map { $0.data }
                .decode(type: [Drink].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    debugPrint("Handle Error")
                }
            }, receiveValue: { (drinks) in
                self?.output?.applySnapshotForDrinks(for: drinks)
            })
        }
    }
    
    func addToCart(item itemInfo:ItemInfo){
        if let oldItem = RealmHelper.shared.fetchObject(ofType: Item.self, forPrimaryKey: itemInfo.id){
            RealmHelper.shared.defaultRealm.beginWrite()
            oldItem.quantity += 1
            try? RealmHelper.shared.defaultRealm.commitWrite()
        } else {
            RealmHelper.shared.syncSave(Item.getItem(from: itemInfo))
        }
    }
}
