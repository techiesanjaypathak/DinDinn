//
//  CartInteractor.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import RealmSwift

class CartInteractor {
    weak var output:CartInteractorOutput?
    var apiDataManager = APIDataManager()
    var localDataManager = RealmHelper.shared.defaultRealm
    
    var items : Results<Item>? = nil
    var notificationToken: NotificationToken?
}

extension CartInteractor : CartUseCase {
    func observeItems(){
        items = try? RealmHelper.shared.fetch(type: Item.self, predicate: nil)
        notificationToken?.invalidate()
        notificationToken = items?.observe({ [weak self] (change) in
            switch change {
            case .initial(let itemsResult), .update(let itemsResult, deletions: _, insertions: _, modifications: _):
                self?.output?.updatedItemResult(for:itemsResult.map{$0})
                break
            case .error(let error):
                debugPrint(error)
                break
            }
        })
    }
}
