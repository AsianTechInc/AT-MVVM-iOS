//
//  RepoCell.swift
//  MVVM
//
//  Created by DaoNV on 4/1/17.
//  Copyright © 2017 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

final class RepoCell: UITableViewCell, MVVM.View {
    var viewModel = RepoCellViewModel(repo: nil) {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }

    func updateView() {
        textLabel?.text = viewModel.name
        detailTextLabel?.text = viewModel.desc
    }
}
