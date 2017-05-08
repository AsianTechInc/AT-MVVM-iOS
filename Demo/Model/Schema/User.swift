//
//  User.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import RealmS

final class User: Object, StaticMappable {
    dynamic var id = 0
    dynamic var username: String!
    dynamic var name: String?
    dynamic var email: String?
    dynamic var avatar: String?

    override static func primaryKey() -> String? {
        return "id"
    }

    func mapping(map: Map) {
        username <- map["login"]
        name <- map["name"]
        email <- map["email"]
        avatar <- map["avatar_url"]
    }

    static func objectForMapping(map: Map) -> BaseMappable? {
        return RealmS().object(ofType: self, forMapping: map)
    }
}
