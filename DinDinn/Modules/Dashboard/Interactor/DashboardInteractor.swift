//
//  DashboardInteractor.swift
//  DinDinn
//
//  Created by SanjayPathak on 26/06/21.
//

import Foundation
import RealmSwift

class DashboardInteractor {
    weak var output:DashboardInteractorOutput?
    var apiDataManager = APIDataManager()
    var localDataManager = RealmHelper.shared.defaultRealm
    
    var items : Results<Item>!
    var notificationToken: NotificationToken?
}

extension DashboardInteractor : DashboardUseCase {
    func observeItemsCount() {
        items = try! RealmHelper.shared.fetch(type: Item.self, predicate: nil)
        notificationToken?.invalidate()
        notificationToken = items.observe { [weak self] change in
            switch change {
            case .initial(let items), .update(let items, deletions: _, insertions: _, modifications: _):
                self?.output?.updateCountWithResult(items)
            case .error(let err):
                debugPrint(err)
            }
        }
    }
}
