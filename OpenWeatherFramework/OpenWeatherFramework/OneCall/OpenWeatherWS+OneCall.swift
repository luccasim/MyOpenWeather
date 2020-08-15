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
        
        public let lon             : Double
        public let lat             : Double
        public let timezone        : String
        public let timezoneOffset  : Int
        public let current         : Current
        public let hourly          : [Hourly]
        public let daily           : [Daily]
        
        enum Keys : String, CodingKey {
            case lon, lat, timezone, current, hourly, daily
            case timezoneOffset = "timezone_offset"
        }
        
        public init(from: Decoder) throws {
            
            let container = try from.container(keyedBy: Keys.self)
            
            self.lon            = try container.decode(Double.self, forKey: .lon)
            self.lat            = try container.decode(Double.self, forKey: .lat)
            self.timezone       = try container.decode(String.self, forKey: .timezone)
            self.timezoneOffset = try container.decode(Int.self, forKey: .timezoneOffset)
            self.current        = try container.decode(Current.self, forKey: .current)
            self.hourly         = try container.decode([Hourly].self, forKey: .hourly)
            self.daily          = try container.decode([Daily].self, forKey: .daily)
        }
        
        init(fromJSONData data:Data) throws {
            self = try JSONDecoder().decode(OneCallReponse.self, from: data)
        }
    }
}

public extension OpenWeatherWS.OneCallReponse {
    
    struct Weather : Codable {
        public let id          : Int
        public let main        : String
        public let description : String
        public let icon        : String
    }
    
    struct Current : Codable {
        
        public let dt          : Int
        public let sunrise     : Int
        public let sunset      : Int
        public let temp        : Double
        public let feelsLike   : Double
        public let pressure    : Int
        public let humidity    : Int
        public let dewPoint    : Double
        public let uvi         : Double
        public let clouds      : Int
        public let visibility  : Int
        public let windSpeed   : Double
        public let windDeg     : Int
        public let weather     : [Weather]
        
        enum CodingKeys : String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
    }
    
    struct Hourly : Codable {
        
        public let dt          : Int
        public let temp        : Double
        public let feelsLike   : Double
        public let pressure    : Int
        public let humidity    : Int
        public let dewPoint    : Double
        public let clouds      : Int
        public let visibility  : Int
        public let windSpeed   : Double
        public let windDeg     : Int
        public let weather     : [Weather]
        public let pop         : Double
        
        enum CodingKeys : String, CodingKey {
            case dt, temp, pressure, humidity, clouds, visibility, weather, pop
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
    }
    
    struct Daily : Codable {
        
        public let dt          : Int
        public let sunrise     : Int
        public let sunset      : Int
        public let temp        : Temp
        public let feelsLike   : FeelsLike
        public let pressure    : Int
        public let humidity    : Int
        public let dewPoint    : Double
        public let windSpeed   : Double
        public let windDeg     : Int
        public let weather     : [Weather]
        public let clouds      : Int
        public let pop         : Double
        public let rain        : Double?
        public let uvi         : Double
        
        enum CodingKeys : String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, weather, clouds, pop, rain, uvi
            
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
        
    }
    
    struct Temp : Codable {
        public let day, min, max, night, eve, morn : Double
    }
    
    struct FeelsLike : Codable {
        public let day, night, eve, morn : Double
    }
}
