//
//  PSICell.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 01/12/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation
import UIKit

class PSICell: UITableViewCell {

    @IBOutlet var psiString: [UILabel]!
    @IBOutlet var psiValue: [UILabel]!

    var viewModel: PSICellViewModel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func cellIdentifier()-> String {
        return "PSICell"
    }

    func prepareCell(data: Item?, region: Region?) {
        guard let data = data else { return }
        guard let region = region else { return }
        self.viewModel = PSICellViewModel.init(region: region, data: data)
        self.setUpUI()
    }

    private func setUpUI() {
        guard let viewModel = self.viewModel else { return }
        for label in self.psiString {
            if label.tag > (viewModel.psiString.count - 1) { break }
            label.text = viewModel.psiString[label.tag]
        }
        for (index, label) in psiValue.enumerated() {
            if index > (viewModel.psiValue.count - 1) { break }
            label.text = viewModel.psiValue[index]
        }
    }
}
