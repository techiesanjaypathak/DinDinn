//
//  DDUIRouter.swift
//  DinDinn
//
//  Created by SanjayPathak on 23/06/21.
//

import UIKit

class DashboardRouter {

    weak var view: UIViewController?
    
    static func setupModule(delegate: DashboardScreenDelegate? = nil) -> UINavigationController {
        let navigationController = UIStoryboard(name: "Dashboard", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let dashboardViewController = navigationController.viewControllers.first as! DashboardViewController
        let presenter = DashboardPresenter()
        let interactor = DashboardInteractor()
        let router = DashboardRouter()

        dashboardViewController.presenter = presenter
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = dashboardViewController
        presenter.delegate = delegate
        
        router.view = dashboardViewController
        
        interactor.output = presenter
        
        return navigationController
    }
}

extension DashboardRouter : DashboardWireframe {
    
}
