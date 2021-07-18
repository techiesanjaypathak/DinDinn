//
//  ViewController.swift
//  DinDinn
//
//  Created by SanjayPathak on 23/06/21.
//

import UIKit

class DashboardViewController: DDViewController {
    
    var presenter: DashboardPresentation?
    
    @IBOutlet weak var cartCountBadgeLabel: UILabel!
    @IBOutlet weak var cartCountBadgeBGView: UIView!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var itemContainerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var itemsContainer: UIView!
    @IBOutlet weak var headerContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.addShadow()
        presenter?.observeCartItemCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cartCountBadgeBGView.layer.cornerRadius = cartCountBadgeBGView.frame.size.width/2
    }
    
    @IBAction func showCart(_ sender: Any) {
        performSegue(withIdentifier: "showCartSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        switch segueIdentifier {
        case "showCartSegue":
            guard let cartViewController = segue.destination as? CartViewController else { return }
            cartViewController.presenter = CartRouter.setUpPresenter(with: cartViewController)
        case "productsSegue":
            guard let productViewController = segue.destination as? ProductViewController else { return }
            productViewController.presenter = ProductRouter.setUpPresenter(with: productViewController)
        case "heroSegue":
            break
        default:
            debugPrint("Unhandled segue encountered")
        }
    }
}
extension DashboardViewController: DashboardView {
    func updateUIForCount(count: Int) {
        DispatchQueue.main.async {
            self.cartCountBadgeLabel.text = "\(count)"
            self.cartCountBadgeBGView.isHidden = count < 1
            self.cartView.isHidden = count < 1
        }
    }
}
