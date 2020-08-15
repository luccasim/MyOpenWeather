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
        
        public let coord       : Coord
        public let weathers    : [Weather]
        public let base        : String
        public let main        : Main
        public let visibility  : Int
        public let wind        : Wind
        public let clouds      : Cloud
        public let dt          : Int
        public let sys         : Sys
        public let timezone    : Int
        public let id          : Int
        public let name        : String
        public let cod         : Int
        
        private var message : String?
        
        enum CodingKeys : String, CodingKey {
            case base, main, visibility, wind, clouds, dt, sys, timezone, id, name, cod, message, coord
            case weathers           = "weather"
        }
                
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
            self.visibility = try container.decode(Int.self, forKey: .visibility)
            self.wind       = try container.decode(Wind.self, forKey: .wind)
            self.clouds     = try container.decode(Cloud.self, forKey: .clouds)
            self.dt         = try container.decode(Int.self, forKey: .dt)
            self.sys        = try container.decode(Sys.self, forKey: .sys)
            self.timezone   = try container.decode(Int.self, forKey: .timezone)
            self.id         = try container.decode(Int.self, forKey: .id)
            self.name       = try container.decode(String.self, forKey: .name)

        }
        
        init(fromData data:Data) throws {
            let decoder = JSONDecoder()
            self = try decoder.decode(WeatherReponse.self, from: data)
        }
        
        func set(Model:OWAPIWeather) {
            
            Model.cityName = self.name
            Model.lon = self.coord.lon
            Model.lat = self.coord.lat
            Model.base = self.base
            Model.main = self.weathers[0].main
            Model.desc = self.weathers[0].description
            Model.icon = self.weathers[0].icon
            Model.temp = self.main.temp
            Model.feelsLike = self.main.feelsLike
            Model.tempMin = self.main.tempMin
            Model.tempMax = self.main.tempMax
            Model.pressure = self.main.pressure
            Model.humidity = self.main.humidity
            Model.visibility = self.visibility
            Model.clouds = self.clouds.all
            Model.timezone = self.timezone
            Model.id = self.id
            Model.sunrise = self.sys.sunrise
            Model.sunset = self.sys.sunset
            
        }
    }
}

public extension OpenWeatherFramework.OpenWeatherWS.WeatherReponse {
    
    struct Coord : Codable {
        public let lon : Double
        public let lat : Double
    }
    
    struct Weather : Codable {
        public let id              : Int
        public let main            : String
        public let description     : String
        public let icon            : String
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
        
        public let temp            : Double
        public let feelsLike       : Double
        public let tempMin         : Double
        public let tempMax         : Double
        public let pressure        : Int
        public let humidity        : Int
    }
    
    struct Wind : Codable {
        public let speed           : Double
        public let deg             : Int
    }
    
    struct Cloud : Codable {
        public let all             : Int
    }
    
    struct Sys : Codable {
        public let type, id, sunrise, sunset : Int
        public let country : String
    }
    
}
