//
//  AppConfiguration.swift
//  DinDinn
//
//  Created by SanjayPathak on 23/06/21.
//

import Foundation

class AppConfiguration: NSObject {
    static let `default` = AppConfiguration()
    var defaults: UserDefaults {
        return  UserDefaults.init(suiteName:"group.com.sanjaypathak.DinDinn")!
    }
    private let kUserLoggedIn = "LOGGED_IN"
    private let kLogin = "USERNAME"
    private var _isLoggedIn: Bool = false
    private var _userName: String?
    
    var username: String? {
        set {
            _userName = newValue
            defaults.set(_userName, forKey: kLogin)
            defaults.synchronize()
        }
        get {
            return defaults.value(forKey: kLogin) as? String
        }
    }
    
    var isLoggedIn: Bool {
        set {
            _isLoggedIn = newValue
            defaults.set(_isLoggedIn, forKey: self.keyForDefaults(userDefaultConstant: kUserLoggedIn))
            
            defaults.synchronize()
        }
        get {
            if (self.keyForDefaults(userDefaultConstant: kUserLoggedIn) != "") {
                return defaults.bool(forKey: self.keyForDefaults(userDefaultConstant: kUserLoggedIn))
            }
            else{
                return false
            }
        }
    }
    
    func keyForDefaults(userDefaultConstant: String?) -> String {
        var constant = ""
        if let username = self.username{
            constant = "\(username.uppercased())\("_")\(userDefaultConstant!)"
        }
        return constant
    }
    
    func flushAllDefaults() {
        defaults.removeObject(forKey: self.keyForDefaults(userDefaultConstant: kUserLoggedIn))
    }
}
