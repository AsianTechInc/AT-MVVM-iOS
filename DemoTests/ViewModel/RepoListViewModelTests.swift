//
//  RepoListViewModelTests.swift
//  MVVM
//
//  Created by DaoNV on 4/17/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import XCTest
import MVVM
import RealmSwift
import ObjectMapper
import RealmS
@testable import Demo

final class RepoListViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        let login = LoginViewModel.standard
        api.session.credential = Session.Credential(
            name: login.username,
            pass: login.accessToken
        )
    }

    func testGetRepos() {
        let ex = expectation(description: "testGetRepos")
        let vm = RepoListViewModel()
        vm.delegate = self
        vm.fetch()
        vm.getRepos { (result) in
            switch result {
            case .success:
                let repos = RealmS().objects(Repo.self)
                guard vm.numberOfSections > 0 else { return }
                XCTAssertEqual(repos.count, vm.numberOfRowsInSection(0))
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            ex.fulfill()
        }
        waitForExpectations(timeout: Timeout.forRequest)
    }
}

extension RepoListViewModelTests: ViewModelDelegate {
    func viewModel(change changes: CollectionChanges) {
    }
}
