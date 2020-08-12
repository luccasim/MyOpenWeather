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
        case unvalidQueryCharacter
        case serverCodError(Cod:String,Msg:String)
    }
    
}

extension OpenWeatherWS.APIError : LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .unvalidQueryCharacter:
            return "One parameter was unvalid for https:// request"
        case .serverCodError(Cod: let cod, Msg: let msg):
            return "Server Cod = \(cod) Msg : \(msg)"
        }
    }
    
}
