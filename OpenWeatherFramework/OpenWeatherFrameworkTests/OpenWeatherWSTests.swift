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
    
    let session = URLSession(configuration: .default)
    let key     = "49e6a41dfca8bdde9592c1272dca877d"
    
    var service : OpenWeatherWS!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.service = OpenWeatherWS(APIKey: self.key, Session: self.session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        self.service = nil
    }
    
    func testInit() throws {
        XCTAssert(self.service != nil)
    }
    
    func testWeatherRequest() throws {
        
        let request = self.service.request(Endpoint: .weather(City: "Paris"))
        
        XCTAssert(request != nil)
        
        print(request!.url!.absoluteString)
    }
    
    func sharedSessionTask(url:URL) throws {
    
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
    
    func testsAPITask() throws {
        
        let city = "SomewhereOnMars"
        let weather = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key)")!
        
        try self.sharedSessionTask(url: weather)
        
        let oneCall = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=48.85&lon=2.35&exclude=minutely&appid=\(key)")!
        
        try self.sharedSessionTask(url: oneCall)
    }
    
    func weatherTask(City:String) throws {
        
        let exp = expectation(description: "Call WebService")
        var reponse : String?
        
        self.service.weatherTask(CityName: City) { (result) in
            
            switch result {
            case .success(let data): reponse = data.weathers[0].description
            case .failure(let error): reponse = error.localizedDescription
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssert(error == nil)
        }
        
        XCTAssert(reponse != nil)
        
        print(reponse!)
    }
    
    func testsWeatherTask() throws {
        
        // Valid
        try self.weatherTask(City: "Paris")
        
        // Unallowed query
        try self.weatherTask(City: "Pær is")
        
        // Town doesn't Exist
        try self.weatherTask(City: "SomewhereOnMars")
    }
    
    func onCallTask(Coordinates:(Lon:Double,Lat:Double)) throws {
        
        let exp = expectation(description: "onCall Task")
        var reponse : String?
        
        self.service.oneCallTask(Coordinates: Coordinates) { (result) in
            
            switch result {
            case .success(let data): reponse = data.timezone
            case .failure(let error): reponse = error.localizedDescription
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssert(error == nil)
        }
        
        XCTAssert(reponse != nil)
        
        print(reponse!)
    }
    
    func testsOnCallTask() throws {
        
        // Paris
        try self.onCallTask(Coordinates: (Lon: 2.35, Lat: 48.85))
        
        // Madrid
        try self.onCallTask(Coordinates: (Lon: -3.703790, Lat: 40.416775))

        // Berlin
        try self.onCallTask(Coordinates: (Lon: 13.404954, Lat: 52.520008))
        
        // Tokyo
        try self.onCallTask(Coordinates: (Lon: 139.731992, Lat: 35.709026))
        
        // Rio
        try self.onCallTask(Coordinates: (Lon: -43.3307, Lat: -22.9201))
        
        // Error
        try self.onCallTask(Coordinates: (Lon: -475495, Lat: 2347984234))
    }
    
    class Model : OWAPIWeather {
        
        var sysCountry: String = ""
        
        var visibility: Int = 0
        var timezone: Int = 0
        var id: Int = 0
        
        var cityNameRequest: String = "Tours"
        
        var coordLon: Double = 0
        var coorLat: Double = 0
        var weatherId: Int = 0
        var weatherMain: String = ""
        var weatherDesc: String = ""
        var weatherIcon: String = ""
        var mainTemp: Double = 0
        var mainFeelslike: Double = 0
        var mainPressure: Int = 0
        var mainHumidity: Int = 0
        var mainTempMin: Double = 0
        var mainTempMax: Double = 0
        var windSpeed: Double = 0
        var windDeg: Int = 0
        var cloudsAll: Int = 0
        var dt: Int = 0
        var sysSunrise: Int = 0
        var sysSunset: Int = 0
        var name: String = ""
        
        init() {}
    }
    
    func testUpdate() throws {
        
        let exp = expectation(description: "weather update")
        let model = Model()
        var reponse : String?
        
        self.service.weatherUpdate(Model: model) { (result) in
            
            switch result {
            case .success(let data): reponse = data.description
            case .failure(let error): reponse = error.localizedDescription
            }
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 30) { (error) in
            XCTAssert(error == nil)
        }
        
        XCTAssert(reponse != nil)
        
        print(model.name)

    }
}
