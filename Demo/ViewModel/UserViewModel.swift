//
//  UserVM.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import MVVM

final class UserViewModel: MVVM.ViewModel {
    typealias T = User
    var model: User?
    var origin: T?
    var delegate: UserProvider?

    enum Validation {
        case success
        case failure(key: String, msg: String)
    }

    var name = ""
    var mail = ""
    var pass = ""

    init(model: User?) {
        guard let model = model else { return }
        name = model.name
        mail = model.mail
    }

    func validate() -> Validation {
        guard name.len >= 6 else { return .failure(key: "name", msg: "'name' too short") }
        let mailComps = mail.components(separatedBy: "@")
        guard let mailName = mailComps.first, mailName.len >= 6,
            let mailDomain = mailComps.last, mailDomain.len >= 5
        else {
            return .failure(key: "mail", msg: "'mail' too short")
        }
        guard pass.len >= 8 else { return .failure(key: "pass", msg: "'pass' too short") }
        return .success
    }

    enum LoginResult {
        case success
        case failure(code: Int)
    }

    func login(_ completion: @escaping (LoginResult)->Void) {
        let sv = UserServices(userId: 0)
        sv.login { (_) in
            completion(.success)
        }
    }
}

extension String {
    var len: Int { return characters.count }
}