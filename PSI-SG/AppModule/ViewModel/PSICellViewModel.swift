//
//  PSICellViewModel.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 01/12/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation

class PSICellViewModel {
    private var region: Region
    // Datasource
    private var dataSource: Item

    var psiString: [String]!
    var psiValue: [String]!

    init(region: Region, data: Item) {
        self.region = region
        self.dataSource = data
        self.configureOutput()
    }

    private func configureOutput() {
        self.psiString = dataSource.readings.map({ $0.key })
        let readings = dataSource.readings.map({ $0.value })
        switch region {
        case .NATIONAL:
            psiValue = readings.map({ $0.national.toString() })
            break
        case .CENTRAL:
            psiValue = readings.map({ $0.central.toString() })
            break
        case .NORTH:
            psiValue = readings.map({ $0.north.toString() })
            break
        case .SOUTH:
            psiValue = readings.map({ $0.south.toString() })
            break
        case .EAST:
            psiValue = readings.map({ $0.east.toString() })
            break
        case .WEST:
            psiValue = readings.map({ $0.west.toString() })
            break
        }
    }
}
