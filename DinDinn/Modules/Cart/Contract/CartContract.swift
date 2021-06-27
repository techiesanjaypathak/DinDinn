//
//  CartContract.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation

// MARK:- For Presenter
protocol CartPresentation:class {
    func populateItems()
}

protocol CartScreenDelegate {
    
}

// MARK:- For Interactor
protocol CartUseCase:class {
    func observeItems()
}

protocol CartInteractorOutput:class{
    func updatedItemResult(for items:[Item])
}

// MARK:- For Router
protocol CartWireframe:class {
    
}
