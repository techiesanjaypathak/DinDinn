//
//  ProductViewController.swift
//  DinDinn
//
//  Created by SanjayPathak on 23/06/21.
//

import UIKit
import Combine

class ProductViewController: UIViewController {
    
    var presenter: ProductPresentation?

    @IBOutlet weak var drinkHeaderLabel: UILabel!
    @IBOutlet weak var sushiHeaderLabel: UILabel!
    @IBOutlet weak var pizzaHeaderLabel: UILabel!
    
    @IBOutlet weak var drinkTableMessageLabel: UILabel!
    @IBOutlet weak var sushiTableMessageLabel: UILabel!
    @IBOutlet weak var pizzaTableMessageLabel: UILabel!
    
    @IBOutlet weak var masterScroll: UIScrollView!
    @IBOutlet weak var pizzaTable: UITableView!
    @IBOutlet weak var sushiTable: UITableView!
    @IBOutlet weak var drinksTable: UITableView!
    
    @IBOutlet weak var drinksTableWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sushiTableWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pizzaTableWidthConstraint: NSLayoutConstraint!
    
    var pizzaDataSource: UITableViewDiffableDataSource<PizzaSection,Pizza>!
    var sushiDataSource: UITableViewDiffableDataSource<SushiSection,Sushi>!
    var drinkDataSource: UITableViewDiffableDataSource<DrinkSection,Drink>!
    
    var addItemTokens = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinksTableWidthConstraint.constant = view.frame.size.width
        sushiTableWidthConstraint.constant = view.frame.size.width
        pizzaTableWidthConstraint.constant = view.frame.size.width

        pizzaTable.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        sushiTable.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        drinksTable.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "itemCell")
        
        presenter?.populateProducts()
        
        pizzaDataSource = UITableViewDiffableDataSource<PizzaSection,Pizza>(tableView: pizzaTable, cellProvider: { (tableView, indexPath, pizza) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell()}
            cell.configureCell(withItemInfo: ItemInfo.getItemInfo(from: pizza))
            cell.addItemPublisher.sink { (itemInfo) in
                self.presenter?.addItem(itemInfo: itemInfo)
            }.store(in: &self.addItemTokens)
            return cell
        })
        
        sushiDataSource = UITableViewDiffableDataSource<SushiSection,Sushi>(tableView: sushiTable, cellProvider: { (tableView, indexPath, sushi) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell()}
            cell.configureCell(withItemInfo: ItemInfo.getItemInfo(from: sushi))
            cell.addItemPublisher.sink { (itemInfo) in
                self.presenter?.addItem(itemInfo: itemInfo)
            }.store(in: &self.addItemTokens)
            return cell
        })
        
        drinkDataSource = UITableViewDiffableDataSource<DrinkSection,Drink>(tableView: drinksTable, cellProvider: { (tableView, indexPath, drink) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell()}
            cell.configureCell(withItemInfo: ItemInfo.getItemInfo(from: drink))
            cell.addItemPublisher.sink { (itemInfo) in
                self.presenter?.addItem(itemInfo: itemInfo)
            }.store(in: &self.addItemTokens)
            return cell
        })
    }
    
    
}

extension ProductViewController: ProductView {
    func applySnapshot(for pizzas:[Pizza]){
        pizzaTableMessageLabel.text = pizzas.count < 1 ? "No Pizzas left" : ""
        var snapshot = NSDiffableDataSourceSnapshot<PizzaSection,Pizza>()
        snapshot.appendSections([.one])
        snapshot.appendItems(pizzas)
        pizzaDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    func applySnapshot(for sushis:[Sushi]){
        sushiTableMessageLabel.text = sushis.count < 1 ? "No Sushis left" : ""
        var snapshot = NSDiffableDataSourceSnapshot<SushiSection,Sushi>()
        snapshot.appendSections([.one])
        snapshot.appendItems(sushis)
        sushiDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    func applySnapshot(for drinks:[Drink]){
        drinkTableMessageLabel.text = drinks.count < 1 ? "No Drinks left" : ""
        var snapshot = NSDiffableDataSourceSnapshot<DrinkSection,Drink>()
        snapshot.appendSections([.one])
        snapshot.appendItems(drinks)
        drinkDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension ProductViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == masterScroll {
            if scrollView.contentOffset.x+1 > 2*view.frame.size.width {
                pizzaHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
                sushiHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
                drinkHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
            } else if scrollView.contentOffset.x+1 > view.frame.size.width {
                pizzaHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
                sushiHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                drinkHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            } else {
                pizzaHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .bold)
                sushiHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
                drinkHeaderLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
            }
        } else {
            guard let dashboardVC = self.parent as? DashboardViewController else { return }
            let topGap = 300 - scrollView.contentOffset.y
            dashboardVC.itemContainerTopConstraint.constant = topGap > 0 ? topGap : 0
            dashboardVC.cartView.isHidden = false
        }
    }
}
