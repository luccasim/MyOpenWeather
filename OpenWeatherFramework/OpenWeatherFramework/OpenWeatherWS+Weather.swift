//
//  OpenWeatherWS+Weather.swift
//  OpenWeatherFramework
//
//  Created by owee on 11/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public extension OpenWeatherWS {
    
    struct WeatherReponse : Codable {
        
        let coord : Coord
        
        struct Coord : Codable {
            let lon : Double
            let lat : Double
        }
        
        struct Weather {
            let id              : String
            let main            : String
            let description     : String
            let icon            : String
        }
        
        struct Main {
            let temp            : String
            let feelsLike       : String
            let tempMin         : String
            let tempMax         : String
            let pressure        : String
            let humidity        : String
        }
        
        struct Wind {
            let speed           : String
            let deg             : String
        }
        
        struct Cloud {
            let all             : String
        }
        
        struct Sys {
            let type, id, country, sunrise, sunset : String
        }
        
        init(fromData data:Data) throws {
            let decoder = JSONDecoder()
            self = try decoder.decode(WeatherReponse.self, from: data)
        }
    }
}
