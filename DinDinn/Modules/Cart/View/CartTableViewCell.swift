//
//  CartTableViewCell.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import UIKit

protocol ItemOperationDelegate: class {
    func removeItemFromCart(_ indexPath:IndexPath)
}

class CartTableViewCell: UITableViewCell {
    
    weak var delegate:ItemOperationDelegate? = nil

    @IBOutlet weak var removeItemButton: UIButton!
    @IBOutlet weak var cancelImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    var indexPath = IndexPath(row: 0, section: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func removeItem(_ sender: Any) {
        delegate?.removeItemFromCart(indexPath)
    }
    
    func configureCell(withItem item:Item){
        itemImageView.sd_setImage(with: URL(string: item.image)!, placeholderImage: nil, options: .retryFailed)
        itemName.text = item.name
        amountLabel.text = calculateAmount(fromItem: item)
    }
    
    private func calculateAmount(fromItem item: Item) -> String {
        return "\(item.price * item.quantity) usd"
    }

}
