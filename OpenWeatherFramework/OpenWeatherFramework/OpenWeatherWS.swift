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
    
    let key : String
    let session : URLSession
    
}
