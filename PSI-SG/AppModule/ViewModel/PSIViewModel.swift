//
//  PASIViewModel.swift
//  PSI-SG
//
//  Created by Praful Mahajan on 30/11/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation

class PSIViewModel {

    /// Callback to pass the selected place.
    var psiIndex: PSIModel?

    /// Callback to Update map.
    var updateUI: ()->() = { }

    /// Callback to reload the table.
    var reloadTable: ()->() = { }

    var numberOfRows = 0
    var region: Region?
    var status: String = ""
    var timeStamp: String = ""
    var updatedTime: String = ""
    var isHealthy: Bool = false

    init() {
        self.getPSIIndex(complete: {  [weak self] (psiModel) in
            self?.psiIndex = psiModel
            self?.preparedTableCellCount()
            self?.updateUI()
        })
    }

    private func preparedTableCellCount() {
        guard let count = self.psiIndex?.items.count, count > 0 else { return }
        self.numberOfRows = count
        self.status = (self.psiIndex?.apiInfo.status ?? "").capitalized
        self.isHealthy = self.status.lowercased() == "healthy"
        if let timestamp = self.psiIndex?.items[0].timestamp {
            self.timeStamp = timestamp.toDateFromGmtString()?.toShowDateWithTime() ?? ""
        }
        if let updateTimestamp = self.psiIndex?.items[0].updateTimestamp {
            self.updatedTime = updateTimestamp.toDateFromGmtString()?.toShowDateWithTime() ?? ""
        }
    }

    func getReadingData(index: Int)-> Item? {
        return self.psiIndex?.items[index]
    }

    func getPSIIndex(complete:@escaping (PSIModel?) -> Void) {
        let apiConfiguration = APIConfiguration(api_SubDomain: API_SUBDOMAIN.ENVIRONMENT, api_EndPoint: API_ENDPOINT.PSI, httpMethod: .get)
        RequestManager.sharedInstance.withGet(apiConfiguration: apiConfiguration) { (json, error) in
            if let response = json {
                let jsonData = response.data(using: .utf8)!
                let psiModel = try! JSONDecoder().decode(PSIModel.self, from: jsonData)
                complete(psiModel)
            }
            else {
                complete(nil)
            }
        }
    }
}
