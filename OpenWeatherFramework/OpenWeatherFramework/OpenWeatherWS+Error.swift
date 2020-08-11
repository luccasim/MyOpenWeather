//
//  OpenWeatherWS+Error.swift
//  OpenWeatherFramework
//
//  Created by owee on 11/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public extension OpenWeatherWS {
    
    enum APIError : Error {
        case unallowedQueryCharacters
    }
    
}
