//
//  DashboardContract.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import RealmSwift

// MARK:- For Presenter
protocol DashboardView:class {
    func updateUIForCount(count:Int)
}

protocol DashboardPresentation:class {
    func observeCartItemCount()
}

protocol DashboardScreenDelegate {
    
}

// MARK:- For Interactor
protocol DashboardUseCase:class {
    func observeItemsCount()
}

protocol DashboardInteractorOutput:class{
    func updateCountWithResult(_ items:Results<Item>)
}

// MARK:- For Router
protocol DashboardWireframe:class {
    
}


