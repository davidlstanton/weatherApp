//
//  ForecastModelTests.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import XCTest
@testable import WeatherApp

class ForecastModelTests: XCTestCase {
    
    func testNoData() {
        let testModel = DayForecastModel(response: HTTPURLResponse(), representation: [:])
        XCTAssertNil(testModel)
    }
    
    func testData() {
        let testData = [
            "dt":1406080800,
            "temp": [
                "day": 297.77,
                "min": 293.52,
                "max": 297.77,
                "night": 293.52,
                "eve": 297.77,
                "morn": 297.77
            ],
            "pressure": 925.04,
            "humidity": 76,
            "weather" : [
                [
                    "id": 803,
                    "main": "Clouds",
                    "description": "broken clouds",
                    "icon":"04d"
                ]
            ]
        ] as [String: Any]
        
        guard let testModel = DayForecastModel(response: HTTPURLResponse(), representation: testData)
            else {
                XCTFail()
                return
        }
        
        XCTAssertTrue(Date(timeIntervalSince1970: 1406080800) == testModel.forecastDate)
        XCTAssertTrue(297.77 == testModel.tempDay)
        XCTAssertTrue(293.52 == testModel.tempNight)
        XCTAssertTrue("broken clouds" == testModel.weatherDescription)
        XCTAssertTrue("04d" == testModel.weatherIcon)
    }
    
}


