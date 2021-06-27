//
//  CartRouter.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import UIKit

class CartRouter {

    weak var view: UIViewController?
    
    static func setupModule(delegate: CartScreenDelegate? = nil) -> UINavigationController {
        let navigationController = UIStoryboard(name: "Cart", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let cartViewController = navigationController.viewControllers.first as! CartViewController
        cartViewController.presenter = setUpPresenter(with: cartViewController, delegate: delegate)
        return navigationController
    }
    
    static func setUpPresenter(with cartViewController: CartViewController, delegate: CartScreenDelegate? = nil) -> CartPresenter {
        let presenter = CartPresenter()
        let interactor = CartInteractor()
        let router = CartRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = cartViewController
        presenter.delegate = delegate
        
        router.view = cartViewController
        
        interactor.output = presenter
        
        return presenter
    }
}

extension CartRouter : CartWireframe {
    
}
