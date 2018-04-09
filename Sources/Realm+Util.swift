//
//  Realm+Util.swift
//  RealmIO
//
//  Created by Yuki Takahashi on 2017/04/24.
//  Copyright © 2018 waft. All rights reserved.
//

import RealmSwift

internal extension Realm {
    func writeAndReturn<T>(block: () throws -> T) throws -> T {
        beginWrite()
        let t: T
        do {
            t = try block()
        } catch let error {
            if isInWriteTransaction { cancelWrite() }
            throw error
        }
        if isInWriteTransaction { try commitWrite() }
        return t
    }
}
