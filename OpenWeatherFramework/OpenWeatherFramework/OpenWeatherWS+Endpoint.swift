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
        case weather
    }
    
    typealias WeatherCallBack = ((Result<Data,Error>) -> Void)
    
    func weatherRequest(CityName name:String) -> URLRequest? {
        
        guard let cityName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return nil}
        
        let call = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(self.key)"
        
        guard let url = URL(string: call) else {return nil}
        
        return URLRequest(url: url)
    }
    
    func weatherCall(CityName name:String, CallBack: @escaping WeatherCallBack) {
        
        guard let request = self.weatherRequest(CityName: name) else {
            return CallBack(.failure(APIError.unallowedQueryCharacters))
        }
        
        self.session.dataTask(with: request) { (data, rep, err) in
        
            if let error = err {
                CallBack(.failure(error))
            }
            
            else if let data = data {
                CallBack(.success(data))
            }
                        
        }.resume()
    }
}
