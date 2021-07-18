//
//  ProductPresenter.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation

class ProductPresenter {
    weak var view : ProductView?
    var router: ProductWireframe?
    var interactor: ProductUseCase?
    var delegate: ProductScreenDelegate?
}

extension ProductPresenter: ProductPresentation {
    func populateProducts() {
        interactor?.fetchPizzas()
        interactor?.fetchSushis()
        interactor?.fetchDrinks()
    }
    func addItem(itemInfo:ItemInfo){
        interactor?.addToCart(item:itemInfo)
    }
}

extension ProductPresenter: ProductInteractorOutput {
    func applySnapshotForPizzas(for pizzas:[Pizza]){
        view?.applySnapshot(for: pizzas)
    }
    
    func applySnapshotForSushis(for sushis:[Sushi]){
        view?.applySnapshot(for: sushis)
    }
    
    func applySnapshotForDrinks(for drinks:[Drink]){
        view?.applySnapshot(for: drinks)
    }
}
