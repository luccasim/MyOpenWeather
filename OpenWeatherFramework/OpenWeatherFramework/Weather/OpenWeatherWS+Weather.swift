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
        
        enum CodingKeys : String, CodingKey {
            case coord
            case weathers           = "weather"
            case base
            case main
            case visibility
            case wind
            case clouds, dt, sys
            case timezone, id, name, cod
        }
        
        let coord       : Coord
        let weathers    : [Weather]
        let base        : String
        let main        : Main
        let visibility  : Double
        let wind        : Wind
        let clouds      : Cloud
        let dt          : Double
        let sys         : Sys
        let timezone    : Double
        let id          : Double
        let name        : String
        let cod         : Double
        
        init(fromData data:Data) throws {
            let decoder = JSONDecoder()
            self = try decoder.decode(WeatherReponse.self, from: data)
        }
        
        struct Coord : Codable {
            let lon : Double
            let lat : Double
        }
        
        struct Weather : Codable {
            let id              : Double
            let main            : String
            let description     : String
            let icon            : String
        }
        
        struct Main : Codable {
            
            enum CodingKeys : String, CodingKey {
                case temp       = "temp"
                case feelsLike  = "feels_like"
                case tempMin    = "temp_min"
                case tempMax    = "temp_max"
                case pressure   = "pressure"
                case humidity   = "humidity"
            }
            
            let temp            : Double
            let feelsLike       : Double
            let tempMin         : Double
            let tempMax         : Double
            let pressure        : Double
            let humidity        : Double
        }
        
        struct Wind : Codable {
            let speed           : Double
            let deg             : Double
        }
        
        struct Cloud : Codable {
            let all             : Double
        }
        
        struct Sys : Codable {
            let type, id, sunrise, sunset : Double
            let country : String
        }
    }
}
