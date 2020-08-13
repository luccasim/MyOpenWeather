//
//  OpenWeatherWSTests+OneCall.swift
//  OpenWeatherFrameworkTests
//
//  Created by owee on 13/08/2020.
//  Copyright © 2020 Devios. All rights reserved.
//

import XCTest
@testable import OpenWeatherFramework

class OpenWeatherWSTests_OneCall: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWeatherReponse() throws {
        
        let bundle = Bundle(identifier: "fr.casimir.OpenWeatherFramework")!
        let path = bundle.path(forResource: "OneCallReponse", ofType: ".json")!
        let url = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: url)
        
        let obj = try OpenWeatherWS.OneCallReponse.init(fromJSONData: data)
        
        print(obj)
    }

}
