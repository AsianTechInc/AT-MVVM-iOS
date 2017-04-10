//
//  RepoListViewModel.swift
//  MVVM
//
//  Created by DaoNV on 3/16/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import RealmSwift
import RealmS
import MVVM

final class RepoListViewModel: MVVM.ViewModel, MVVM.Provider {
    typealias Item = RepoCellViewModel

    private var repos: Results<Repo>?

    func fetch() {
        repos = RealmS().objects(Repo.self).sorted(byKeyPath: "id", ascending: true)
    }

    var numberOfSections: Int {
        guard let _ = repos else {
            return 0
        }
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let repos = repos else {
            return 0
        }
        return repos.count
    }

    func itemForRow(at indexPath: IndexPath) -> RepoCellViewModel {
        guard let repos = repos else {
            fatalError("Please call `fetch()` first.")
        }
        let repo = repos[indexPath.row]
        return RepoCellViewModel(repo: repo)
    }
}
