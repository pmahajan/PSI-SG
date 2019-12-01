//
//  CommonMethods.swift
//
//  Created by Praful Mahajan on 11/08/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation
import UIKit

class CommonMethods {

    static func getViewControllerFromStoryBoard<T: UIViewController>(type: T.Type, storyBoard: Storyboard) -> T? {
        var fullName: String = NSStringFromClass(T.self)
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
            fullName = String(fullName[range.upperBound...])
        }
        return storyboard.instantiateViewController(withIdentifier:fullName) as? T
    }
}
