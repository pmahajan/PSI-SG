//
//  RequestManager.swift
//
//  Created by Praful Mahajan on 11/08/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation

class RequestManager {

    class var sharedInstance :RequestManager {
        struct Singleton {
            static let instance = RequestManager()
        }
        return Singleton.instance
    }

    func withGet(apiConfiguration: APIConfiguration, completionHandler: @escaping JSONCompletionHandler) {
        let configuration = apiConfiguration.configuration()
        let session = URLSession(configuration: configuration)

        if let urlRequest = apiConfiguration.getURLRequest() {
            session.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    if let json = String(data: data, encoding: String.Encoding.utf8) {
                        print("*** Response Json *** \n\(json)")
                        completionHandler(json, nil)
                    }
                    else {
                        completionHandler(nil, error)
                    }
                }
                else {
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }

    func withPost(apiConfiguration: APIConfiguration, completionHandler: @escaping JSONCompletionHandler) {
        let configuration = apiConfiguration.configuration()
        let session = URLSession(configuration: configuration)

        if let urlRequest = apiConfiguration.postURLRequest() {
            session.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    if let json = String(data: data, encoding: String.Encoding.utf8) {
                        print("*** Response Json *** \n\(json)")
                        completionHandler(json, nil)
                    }
                    else {
                        completionHandler(nil, error)
                    }
                }
                else {
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }
}
