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
            case message
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
        let cod         : Int
        
        private var message : String?
                
        public init(from decoder:Decoder) throws {
            
            let container   = try decoder.container(keyedBy: CodingKeys.self)
            
            // On error, cod is a String
            if let error = try? container.decode(String.self, forKey: .cod) {
                self.message = try container.decode(String.self, forKey: .message)
                throw APIError.serverCodError(Cod: error, Msg: self.message ?? "")
            }
            
            else {
                self.cod = try container.decode(Int.self, forKey: .cod)
            }
            
            self.coord      = try container.decode(Coord.self, forKey: .coord)
            self.weathers   = try container.decode([Weather].self, forKey: .weathers)
            self.base       = try container.decode(String.self, forKey: .base)
            self.main       = try container.decode(Main.self, forKey: .main)
            self.visibility = try container.decode(Double.self, forKey: .visibility)
            self.wind       = try container.decode(Wind.self, forKey: .wind)
            self.clouds     = try container.decode(Cloud.self, forKey: .clouds)
            self.dt         = try container.decode(Double.self, forKey: .dt)
            self.sys        = try container.decode(Sys.self, forKey: .sys)
            self.timezone   = try container.decode(Double.self, forKey: .timezone)
            self.id         = try container.decode(Double.self, forKey: .id)
            self.name       = try container.decode(String.self, forKey: .name)

        }
        
        init(fromData data:Data) throws {
            let decoder = JSONDecoder()
            self = try decoder.decode(WeatherReponse.self, from: data)
        }
        
    }
}

public extension OpenWeatherFramework.OpenWeatherWS.WeatherReponse {
    
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
