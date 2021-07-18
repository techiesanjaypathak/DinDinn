//
//  RealmHelper.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import RealmSwift

enum RealmError: Error {
    case realmFileNotFound
}

class RealmHelper {
    
    static let shared = RealmHelper()
    
    private init(){}
    
    var defaultRealm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    /** This creates a custom realm db file lazily**/

    var configuration: Realm.Configuration = {
//        var migrationConfig: Realm.Configuration = Realm.Configuration(
//            // Set the new schema version. This must be greater than the previously used
//            // version (if you've never set a schema version before, the version is 0).
//            schemaVersion: 0,
//            migrationBlock: { migration, oldSchemaVersion in })
        
//        Realm.Configuration.defaultConfiguration = migrationConfig
        var realmConfig: Realm.Configuration = Realm.Configuration()
        guard let documentsDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first else {
            return realmConfig
        }
        realmConfig.shouldCompactOnLaunch = { (totalBytes: Int, usedBytes: Int) -> Bool in
            return true
        }
        var realmDB = "/DinDinn.realm"
        let customDirectory = documentsDirectory + realmDB
        realmConfig.fileURL =  URL(string: customDirectory)
        return realmConfig
    }()
    
    //MARK:- Create

    /** All save operations by default done in asynchronus manner**/
    func syncSave<T: Object>(_ realmObject: T) {
        let backgroundQueue = DispatchQueue(label: ".realm", qos: .background)
        var defaultRealm: Realm?
        backgroundQueue.sync {
            autoreleasepool {
                do {
                    defaultRealm = try Realm(configuration: self.configuration)
                } catch let error {
                    debugPrint("Realm Can't be created on  thread \(Thread.current) and error is \(error.localizedDescription)")
                }
                if let realm = defaultRealm {
                    do {
                        try realm.write {
                            realm.add(realmObject)
                        }
                    } catch let error {
                        debugPrint(" Can't add Realm Object on thread \(Thread.current) thread and error is \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func asyncSaveWithPrimaryKey<T: Object>(_ realmObject: T) {
        let backgroundQueue = DispatchQueue(label: ".realm", qos: .background)
        var defaultRealm: Realm?
        backgroundQueue.async {
            do {
                defaultRealm = try Realm(configuration: self.configuration)
            } catch let error {
                debugPrint("Realm Can't be created on  thread \(Thread.current) and error is \(error.localizedDescription)")
            }
            if let realm = defaultRealm {
                do {
                    try realm.write {
                        realm.add(realmObject, update: .all)
                    }
                } catch let error {
                    debugPrint(" Can't add Realm Object on thread \(Thread.current) thread and error is \(error.localizedDescription)")
                }
            }
        }
    }
    
    func save<T: Object>(_ realmObject: T) {
        var defaultRealm: Realm?
        do {
            defaultRealm = try Realm(configuration: self.configuration)
        } catch let error {
            debugPrint("Realm Can't be created on main thread and error is \(error.localizedDescription)")
        }
        if let realm = defaultRealm {
            do {
                try realm.write {
                    realm.add(realmObject)
                }
            } catch let error {
                debugPrint(" Can't add Realm Object on main thread and error is \(error.localizedDescription)")
            }
        }
    }
    
    func saveWithPrimaryKey<T: Object>(_ realmObject: T) {
        var defaultRealm: Realm?
        do {
            defaultRealm = try Realm(configuration: self.configuration)
        } catch let error {
            debugPrint("Realm Can't be created on main thread and error is \(error.localizedDescription)")
        }
        if let realm = defaultRealm {
            do {
                try realm.write {
                    realm.add(realmObject, update: .all)
                }
            } catch let error {
                debugPrint(" Can't add Realm Object on main thread and error is \(error.localizedDescription)")
            }
        }
    }

    // MARK:- Read
    /** Read operations are run in background by default **/

    func fetchObject<T: Object, K>(ofType type: T.Type, forPrimaryKey key: K) -> T? {
        var realm :Realm?
        do {
            realm = try Realm(configuration: self.configuration)
        } catch let error as NSError {
            debugPrint(error.localizedDescription)
        }
        let obj = realm?.object(ofType: type, forPrimaryKey: key)
        return obj
    }
    
    func fetch<T: Object>(type _: T.Type, predicate: NSPredicate?) throws -> Results<T> {
        let results: Results<T>!
        do {
            let realm = try Realm(configuration: self.configuration)
            realm.refresh()
            if let predicate = predicate {
                results = realm.objects(T.self).filter(predicate)
            } else {
                results = realm.objects(T.self)
            }
        } catch let error {
            throw error
        }
        return results
    }
    
    
    // MARK:- Update
    
    func updateObjects<T: Object>(type _: T.Type, predicate: NSPredicate, updateBlock: (T) -> Void) {
        autoreleasepool {
            do {
                let realm = try Realm(configuration: self.configuration)
                let results = realm.objects(T.self).filter(predicate)
                try realm.safeWrite {
                    for object in results {
                        updateBlock(object)
                    }
                }
            } catch {
                debugPrint(error)
            }
        }
    }
    
    // MARK:- Delete
    
    func delete(_ T: Object) {
        do {
            let realm = try Realm(configuration: self.configuration)
            do {
                try realm.safeWrite {
                realm.delete(T)
                }
            } catch let error as NSError {
                debugPrint(error)
            }
        } catch let error as NSError {
            debugPrint(error)
        }
    }

    func deleteAll() {
        let realm = try! Realm(configuration: self.configuration)
        try! realm.write {
            realm.deleteAll()
        }
    }

}
