//
//  CartPresenter.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation

class CartPresenter {
    weak var view : CartViewController?
    var router: CartWireframe?
    var interactor: CartUseCase?
    var delegate: CartScreenDelegate?
}

extension CartPresenter: CartPresentation {
    func populateItems() {
        interactor?.observeItems()
    }
}

extension CartPresenter: CartInteractorOutput {
    func updatedItemResult(for items: [Item]) {
        view?.applySnapshot(for: items)
    }
}
