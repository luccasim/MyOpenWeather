//
//  OpenWeatherWSTests.swift
//  EngineTests
//
//  Created by owee on 10/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import XCTest
@testable import OpenWeatherFramework

class OpenWeatherWSTests: XCTestCase {
    
    var service : OpenWeatherWS!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.service = OpenWeatherWS()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.service = nil
    }
    
    func testInit() throws {
        XCTAssert(self.service != nil)
    }

    func testKey() throws {
        
        try testInit()
        
        print("Key = \(self.service.key)")
    }
    
    func testWeatherRequest() throws {
        
        let request = self.service.weatherRequest(CityName: "Paris")
        
        XCTAssert(request != nil)
        
        print(request!.url!.absoluteString)
    }
    
    func testWeatherURLSharedSession() throws {
        
        let key = "49e6a41dfca8bdde9592c1272dca877d"
        let city = "London"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)")!
        
        let exp = expectation(description: "Shared URLSession On Paris!")
        
        var reponse : String?
        
        URLSession.shared.dataTask(with: url) { (data, rep, err) in
            
            if let data = data {
                reponse = String(data: data, encoding: .utf8)
            }
            
            exp.fulfill()
            
        }.resume()
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssert(error == nil)
        }
        
        XCTAssert(reponse != nil)
        
        print(reponse!)
    }
    
    func testWeatherCall() throws {
        
        let exp = expectation(description: "Call WebService")
        var reponse : String?
        
        self.service.weatherCall(CityName: "Paris") { (result) in
            
            switch result {
            case .success(let data): reponse = String(data: data, encoding: .utf8)
            default: break
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssert(error == nil)
        }
        
        XCTAssert(reponse != nil)
        
        print(reponse!)
    }
}
