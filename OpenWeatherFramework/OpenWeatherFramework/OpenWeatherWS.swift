//
//  OpenWeatherWS.swift
//  Engine
//
//  Created by owee on 10/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public final class OpenWeatherWS {
    
    // TODO: init(key:, session:) with user api key, later...
    public init() {}
    
    public let key = "49e6a41dfca8bdde9592c1272dca877d"
    private let session = URLSession(configuration: .default)
    
    public enum Endpoint {
        case weather
    }
    
    public enum APIError : Error {
        case unallowedQueryCharacters
    }
    
    public typealias WeatherCallBack = ((Result<Data,Error>) -> Void)
    
    public func weatherRequest(CityName name:String) -> URLRequest? {
        
        guard let cityName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return nil}
        
        let call = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(self.key)"
        
        guard let url = URL(string: call) else {return nil}
        
        return URLRequest(url: url)
    }
    
    public func weatherCall(CityName name:String, CallBack: @escaping WeatherCallBack) {
        
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
            
            //#osef de la reponse!
            
        }.resume()
    }
}
