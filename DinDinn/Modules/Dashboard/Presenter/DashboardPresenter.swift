//
//  DashboardPresenter.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import RealmSwift

class DashboardPresenter {
    weak var view : DashboardView?
    var router: DashboardWireframe?
    var interactor: DashboardUseCase?
    var delegate: DashboardScreenDelegate?
}

extension DashboardPresenter: DashboardPresentation {
    func observeCartItemCount() {
        interactor?.observeItemsCount()
    }
}

extension DashboardPresenter: DashboardInteractorOutput {
    func updateCountWithResult(_ items:Results<Item>){
        
        let count = items.map{$0.quantity}.reduce(0, +)
        view?.updateUIForCount(count: count)
    }
}
