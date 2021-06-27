//
//  CartViewController.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import UIKit

class CartViewController: UIViewController {
    
    var presenter: CartPresentation?
    
    @IBOutlet weak var emptyTableMessageLabel: UILabel!
    @IBOutlet weak var finalBillViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var informationLabelWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var ordersLabelWidthConstant: NSLayoutConstraint!
    @IBOutlet weak var cartLabelWidthConstant: NSLayoutConstraint!
    
    @IBOutlet weak var totalBillAmountLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var paymentBGView: UIView!
    @IBOutlet weak var finalBillView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: UITableViewDiffableDataSource<ItemSection, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartLabelWidthConstant.constant = view.frame.size.width/3
        ordersLabelWidthConstant.constant = view.frame.size.width/3 + view.frame.size.width/16
        informationLabelWidthConstant.constant = view.frame.size.width/3 + view.frame.size.width/7
        paymentBGView.addShadow()
        
        dataSource = UITableViewDiffableDataSource<ItemSection,Item>(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cartCellReuseIdentifier", for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            cell.indexPath = indexPath
            cell.configureCell(withItem: item)
            return cell
        })
        tableView.tableFooterView = UIView()
        
        presenter?.populateItems()
    }

    @IBAction func goBackToMenu(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CartViewController {
    func applySnapshot(for items:[Item]){
        var snapshot = NSDiffableDataSourceSnapshot<ItemSection,Item>()
        snapshot.appendSections([.one])
        snapshot.appendItems(items)
        self.dataSource.apply(snapshot, animatingDifferences: false, completion: { [weak self] in
            guard let self = self else { return }
            self.totalBillAmountLabel.text = "\(items.map{$0.price*$0.quantity}.reduce(0, +)) usd"
            self.finalBillViewTopConstraint.constant = min(self.tableView.frame.origin.y + self.tableView.contentSize.height, self.view.frame.size.height - self.finalBillView.frame.size.height)
            self.finalBillView.isHidden = items.count == 0
            self.emptyTableMessageLabel.isHidden = items.count != 0
        })
    }
}
extension CartViewController:ItemOperationDelegate{
    func removeItemFromCart(_ indexPath:IndexPath) {
        guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return }
        RealmHelper.shared.delete(item)
    }
}
