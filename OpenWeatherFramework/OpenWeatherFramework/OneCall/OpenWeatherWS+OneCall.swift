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
        
        let lon             : Double
        let lat             : Double
        let timezone        : String
        let timezoneOffset  : Int
        let current         : Current
        let hourly          : [Hourly]
        let daily           : [Daily]
        
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
        let id          : Int
        let main        : String
        let description : String
        let icon        : String
    }
    
    struct Current : Codable {
        
        let dt          : Int
        let sunrise     : Int
        let sunset      : Int
        let temp        : Double
        let feelsLike   : Double
        let pressure    : Int
        let humidity    : Int
        let dewPoint    : Double
        let uvi         : Double
        let clouds      : Int
        let visibility  : Int
        let windSpeed   : Double
        let windDeg     : Int
        let weather     : [Weather]
        
        enum CodingKeys : String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
    }
    
    struct Hourly : Codable {
        
        let dt          : Int
        let temp        : Double
        let feelsLike   : Double
        let pressure    : Int
        let humidity    : Int
        let dewPoint    : Double
        let clouds      : Int
        let visibility  : Int
        let windSpeed   : Double
        let windDeg     : Int
        let weather     : [Weather]
        let pop         : Double
        
        enum CodingKeys : String, CodingKey {
            case dt, temp, pressure, humidity, clouds, visibility, weather, pop
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
    }
    
    struct Daily : Codable {
        
        let dt          : Int
        let sunrise     : Int
        let sunset      : Int
        let temp        : Temp
        let feelsLike   : FeelsLike
        let pressure    : Int
        let humidity    : Int
        let dewPoint    : Double
        let windSpeed   : Double
        let windDeg     : Int
        let weather     : [Weather]
        let clouds      : Int
        let pop         : Double
        let rain        : Double?
        let uvi         : Double
        
        enum CodingKeys : String, CodingKey {
            case dt, sunrise, sunset, temp, pressure, humidity, weather, clouds, pop, rain, uvi
            
            case feelsLike  = "feels_like"
            case dewPoint   = "dew_point"
            case windSpeed  = "wind_speed"
            case windDeg    = "wind_deg"
        }
        
    }
    
    struct Temp : Codable {
        let day, min, max, night, eve, morn : Double
    }
    
    struct FeelsLike : Codable {
        let day, night, eve, morn : Double
    }
}
