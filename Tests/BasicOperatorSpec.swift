//
//  BasicOperatorSpec.swift
//  RealmTxn
//
//  Created by ST20841 on 2017/05/22.
//  Copyright © 2017年 waft. All rights reserved.
//

import Quick
import Nimble
import RealmSwift
import RealmTxn

class BasicOperatorSpec: QuickSpec {
    let realm = try! Realm(configuration: Realm.Configuration(fileURL: nil, inMemoryIdentifier: "for test"))

    override func spec() {
        super.spec()

        describe("`map` operator") {
            beforeEach {
                try! self.realm.write {
                    self.realm.deleteAll()
                    self.realm.add(Dog.dogs)
                }
            }

            it("should work with `map` operator") {
                let txn = Realm.TxnOps
                    .object(ofType: Dog.self, forPrimaryKey: "A")
                    .map { $0?.name ?? "" }
                let result = try! self.realm.run(txn: txn)

                expect(txn).to(beAnInstanceOf(RealmReadTxn<String>.self))
                expect(result).to(equal("A"))
            }
        }
    }
}