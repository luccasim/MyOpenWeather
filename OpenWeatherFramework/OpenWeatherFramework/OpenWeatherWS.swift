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
    
    func request(Endpoint:Endpoint) -> URLRequest? {
        
        guard let baseURL = Endpoint.baseURL else {
            return nil
        }
        
        let query = "\(baseURL)&appid=\(self.key)"
        
        // Check if the query are valid.
        guard let url = URLComponents(string: query)?.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = Endpoint.method
        
        return request
    }
    
    public func weatherCall(CityName name:String, CallBack: @escaping WeatherCallBack) {
        
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
    
}
