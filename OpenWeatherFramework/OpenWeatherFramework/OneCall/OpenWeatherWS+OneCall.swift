//
//  OpenWeatherWS+OneCall.swift
//  OpenWeatherFramework
//
//  Created by owee on 13/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public extension OpenWeatherWS {
    
    struct OneCallReponse : Codable {
        
        init(fromJSONData data:Data) throws {
            self = try JSONDecoder().decode(OneCallReponse.self, from: data)
        }
    }
}
