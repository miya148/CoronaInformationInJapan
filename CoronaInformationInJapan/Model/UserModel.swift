//
//  UserModel.swift
//  CoronaInformationInJapan
//
//  Created by shunsuke.miyano on 2021/06/29.
//

import Foundation
import RealmSwift

class UserModel: Object {
    @objc dynamic var ID: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "ID"
    }
    
    static func addID(realm: Realm) -> Int {
        if let user = realm.objects(UserModel.self).sorted(byKeyPath: "ID").last {
            return user.ID + 1
        } else {
            return 1
        }
    }
    
    static func create(realm: Realm) -> UserModel {
        let user: UserModel = UserModel()
        user.ID = addID(realm: realm)
        return user
    }
}


