//
//  OpenWeatherWS.swift
//  Engine
//
//  Created by owee on 10/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import Foundation

public final class OpenWeatherWS {
    
    public init(APIKey:String, Session:URLSession) {
        self.key = APIKey
        self.session = Session
    }
    
    let key         : String
    let session     : URLSession
    
    /// Create a Valid request with the associate endpoint
    /// - Parameter Endpoint: The desired endpoint . Show OpenWeatherWS.Endpoint
    /// - Returns: The request if the query is valid
    public func request(Endpoint:Endpoint) -> URLRequest? {
        
        guard let baseURL = Endpoint.baseURL else {
            return nil
        }
        
        let query = "\(baseURL)&appid=\(self.key)"
        
        // Check if the query is valid.
        guard let url = URLComponents(string: query)?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Endpoint.method
        
        return request
    }
    
    /// Call Current weather data for one location
    /// - Parameters:
    ///   - name: The location name
    ///   - CallBack: The results of the request. On success return a complet struct.
    /// - SeeAlso : OpenWeatherWS.WeatherReponse
    public func weatherTask(CityName name:String, CallBack: @escaping WeatherCallBack) {
        
        guard let request = self.request(Endpoint: .weather(City: name)) else {
            return CallBack(.failure(APIError.unvalidQueryCharacter))
        }
        
        self.session.dataTask(with: request) { (data, rep, err) in
        
            if let error = err {
                CallBack(.failure(error))
            }
            
            else if let data = data {
                
                do {
                    
                    let reponse = try WeatherReponse.init(fromData: data)
                    CallBack(.success(reponse))
                    
                } catch let error {
                    CallBack(.failure(error))
                }
            }
                        
        }.resume()
    }
    
    
    /// Call Current and forecast weather data
    /// You should have longitude and latitude
    /// - Parameters:
    ///   - Coordinates: Geographical coordinates of the location
    ///   - CallBack: The results of the request. On success return a complet struct (See OpenWeatherWS.WeatherReponse).
    public func oneCallTask(Coordinates:(Lon:Double,Lat:Double), CallBack: @escaping OneCallCallBack) {
        
        guard let request = self.request(Endpoint: .oneCall(Lat: Coordinates.Lat, Long: Coordinates.Lon)) else {
            return CallBack(.failure(APIError.unvalidQueryCharacter))
        }
        
        self.session.dataTask(with: request) { (data, rep, err) in
        
            if let error = err {
                CallBack(.failure(error))
            }
            
            else if let data = data {
                
                do {
                    
                    let reponse = try OneCallReponse.init(fromJSONData: data)
                    CallBack(.success(reponse))
                    
                } catch let error {
                    CallBack(.failure(error))
                }
            }
                        
        }.resume()
    }
    
    /// Call Current weather data for one location
    /// Use this method if you desire update your model. Update trigger if your dt model are different.
    /// - Parameters:
    ///   - Model: Model with OWAPI protocol
    ///   - Result: Async Result, true after updating.
    public func weatherUpdate(Model:OWAPIWeather, Result: @escaping (Result<Bool,Error>)->()) {
        
        guard let request = self.request(Endpoint: .weather(City: Model.cityNameRequest)) else {
            return Result(.failure(APIError.unvalidQueryCharacter))
        }
        
        self.session.dataTask(with: request) { (data, rep, err) in
        
            if let error = err {
                Result(.failure(error))
            }
            
            else if let data = data {
                
                do {
                    
                    let reponse = try WeatherReponse.init(fromData: data)
                    DispatchQueue.main.async {
                        Result(.success(reponse.upDate(Model: Model)))
                    }

                } catch let error {
                    Result(.failure(error))
                }
            }
                        
        }.resume()
    }
}
