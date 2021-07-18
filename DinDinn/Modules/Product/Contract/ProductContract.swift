//
//  ProductContract.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation

// MARK:- For Presenter
protocol ProductView:class {
    func applySnapshot(for pizzas:[Pizza])
    func applySnapshot(for pizzas:[Sushi])
    func applySnapshot(for pizzas:[Drink])
}

protocol ProductPresentation:class {
    func populateProducts()
    func addItem(itemInfo:ItemInfo)
}

protocol ProductScreenDelegate {
    
}

// MARK:- For Interactor
protocol ProductUseCase:class {
    func fetchPizzas()
    func fetchSushis()
    func fetchDrinks()
    func addToCart(item:ItemInfo)
}

protocol ProductInteractorOutput:class{
    func applySnapshotForPizzas(for pizzas:[Pizza])
    func applySnapshotForSushis(for pizzas:[Sushi])
    func applySnapshotForDrinks(for pizzas:[Drink])
}

// MARK:- For Router
protocol ProductWireframe:class {
    
}
