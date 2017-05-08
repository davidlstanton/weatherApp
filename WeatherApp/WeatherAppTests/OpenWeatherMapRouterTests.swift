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
        let expectedResult = "http://api.openweathermap.org/data/2.5/forecast/daily?id=2648110&units=metric&appid=429526511ef680c746780f52256f740a"
        guard let testResult = try? OpenWeatherMapRouter.forcast7DaysDaily(cityId: 2648110).asURLRequest().url?.absoluteString
            else {
                XCTFail()
                return
        }
        XCTAssert(expectedResult == testResult)
    }
    
}
