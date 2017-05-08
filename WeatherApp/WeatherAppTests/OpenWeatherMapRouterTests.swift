//
//  OpenWeatherMapRouterTests.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import XCTest
@testable import WeatherApp

class OpenWeatherMapRouterTests: XCTestCase {
    
    func testForecast7DaysDaily() {
        
        // Note that this is not foolproof as parameters can be in any order.  Checking path + parameters would be better.
        // For an MVP this is much quicker.
        let expectedResult = "http://api.openweathermap.org/data/2.5/forecast/daily?appid=429526511ef680c746780f52256f740a&id=2648110&units=metric"
        guard let testResult = try? OpenWeatherMapRouter.forecast7DaysDaily(cityId: 2648110).asURLRequest().url?.absoluteString
            else {
                XCTFail()
                return
        }
        XCTAssert(expectedResult == testResult)
    }
    
}
