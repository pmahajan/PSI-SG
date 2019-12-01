//
//  PSI_SGTests.swift
//  PSI-SGTests
//
//  Created by Praful Mahajan on 30/11/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Quick
import Nimble
@testable import PSI_SG

class PSI_SGTests: QuickSpec {

    var viewModel: PSIViewModel!
    override func spec() {
        viewModel = PSIViewModel.init()
        observeEvents()
    }

    /// Function to observe various event call backs from the viewmodel as well as Notifications.
    private func observeEvents() {
        viewModel?.updateUI = { [weak self] in
            DispatchQueue.main.async(execute: {
                expect(self?.viewModel.psiIndex).toEventuallyNot(beNil())
            })
        }
    }
}
