//
//  OpenWeatherWSTests+Endpoint.swift
//  OpenWeatherFrameworkTests
//
//  Created by owee on 11/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import XCTest
@testable import OpenWeatherFramework

class OpenWeatherWSTests_Endpoint: XCTestCase {
    
    var endpoint : OpenWeatherWS.Endpoint!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.endpoint = OpenWeatherWS.Endpoint.weather(City: "Paris")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.endpoint = nil
    }
    
    func testEndpointURL() throws {
        
        let url = self.endpoint.baseURL
        
        XCTAssert(url != nil)
        
        print(url!)
    }
}
