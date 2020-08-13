//
//  OpenWeatherWS+Endpoint.swift
//  OpenWeatherFramework
//
//  Created by owee on 11/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public extension OpenWeatherWS {
    
    enum Endpoint {
        
        case weather(City:String)
        case oneCall(Lat:Double, Long:Double)
        case none
        
        var baseURL : String? {
            
            switch self {
            case .weather(City: let city):
                return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&lang=fr"
            case .oneCall(Lat: let lat, Long: let long):
                return "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely"
            default: return nil
            }
        }
        
        var method : String? {
            
            switch self {
            case .weather(City: _), .oneCall(Lat: _, Long: _): return "GET"
            default: return nil
            }
        }
    }
    
    typealias WeatherCallBack = ((Result<WeatherReponse, Error>) -> Void)
    typealias OneCallCallBack = ((Result<OneCallReponse, Error>) -> Void)
    
}
