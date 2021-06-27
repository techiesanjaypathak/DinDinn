//
//  Realm+.swift
//  DinDinn
//
//  Created by SanjayPathak on 25/06/21.
//

import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) throws {
        do {
            if isInWriteTransaction {
                try block()
            } else {
                try write(block)
            }
        } catch {
            throw error
        }
    }
}
