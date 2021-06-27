//
//  ItemTableViewCell.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    var itemInfo:ItemInfo!
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemQuantityLabel: UILabel!
    @IBOutlet weak var itemPriceButton: DDAddToCartButton!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.sd_cancelCurrentImageLoad()
        itemImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBGView.addShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        itemImageView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    func configureCell(withItemInfo itemInfo:ItemInfo){
        self.itemInfo = itemInfo
        itemImageView.sd_setImage(with: itemInfo.imageURL, placeholderImage: nil, options: .retryFailed)
        itemName.text = itemInfo.name
        itemQuantityLabel.text = getQuantityText(formItemInfo: itemInfo)
        itemPriceButton.setTitle("\(itemInfo.price) usd", for: .normal)
        itemDescription.text = itemInfo.desc
    }
    
    private func getQuantityText(formItemInfo itemInfo:ItemInfo) -> String {
        switch itemInfo.type {
        case "Pizza":
            return "\(itemInfo.weight) kg, \(itemInfo.dimension) cm"
        case "Sushi":
            return "\(itemInfo.pieces) pieces, \(itemInfo.weight) gm"
        case "Drink":
            return "\(itemInfo.volume) ml, \(itemInfo.pieces) bottles"
        default:
            return ""
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        if let oldItem = RealmHelper.shared.fetchObject(ofType: Item.self, forPrimaryKey: itemInfo.id){
            RealmHelper.shared.defaultRealm.beginWrite()
            oldItem.quantity += 1
            try? RealmHelper.shared.defaultRealm.commitWrite()
        } else {
            RealmHelper.shared.asyncSave(Item.getItem(from: itemInfo))
        }
    }
}
