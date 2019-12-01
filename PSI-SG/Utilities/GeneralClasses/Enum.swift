//
//  Enum.swift
//
//  Created by Praful Mahajan on 11/08/19.
//  Copyright © 2019 prafulmahajan. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

public enum Storyboard: String {
    case MAIN = "Main"
    case LAUNCHSCREEN = "LaunchScreen"
    case CHAT = "Chat"
}

public enum Region: String {
    case NATIONAL = "national"
    case CENTRAL = "central"
    case NORTH = "north"
    case SOUTH = "south"
    case EAST = "east"
    case WEST = "west"
}
