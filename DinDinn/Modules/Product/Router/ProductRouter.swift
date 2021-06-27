//
//  ProductRouter.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import UIKit

class ProductRouter {

    weak var view: UIViewController?
    
    static func setupModule(delegate: ProductScreenDelegate? = nil) -> UINavigationController {
        let navigationController = UIStoryboard(name: "Product", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let productViewController = navigationController.viewControllers.first as! ProductViewController
        productViewController.presenter = setUpPresenter(with: productViewController, delegate: delegate)
        return navigationController
    }
    
    static func setUpPresenter(with productViewController: ProductViewController, delegate: ProductScreenDelegate? = nil) -> ProductPresenter {
        let presenter = ProductPresenter()
        let interactor = ProductInteractor()
        let router = ProductRouter()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = productViewController
        presenter.delegate = delegate
        
        router.view = productViewController
        
        interactor.output = presenter
        
        return presenter
    }
}

extension ProductRouter : ProductWireframe {
    
}
