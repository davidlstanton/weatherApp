//
//  DayForecastModelTests.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import XCTest
@testable import WeatherApp

class DayForecastModelTests: XCTestCase {
    
    func testNoData() {
        let testModel = ForecastModel(response: HTTPURLResponse(), representation: [:])
        XCTAssertNil(testModel)
    }
    
    func testData() {
        let testData = [
            "cod": "200",
            "message": 0.0032,
            "city": [
                "id": 1851632,
                "name": "Shuzenji",
                "coord": ["lon": 138.933334, "lat": 34.966671],
                "country": "JP"
                ],
            "cnt": 10,
            "list": [
                    [
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
                    ]
                    ]
        ] as [String : Any]
        guard let testModel = ForecastModel(response: HTTPURLResponse(), representation: testData)
            else {
                XCTFail()
                return
        }
        XCTAssertTrue("JP" == testModel.cityCountryCode)
        XCTAssertTrue(1851632 == testModel.cityId)
        XCTAssertTrue("Shuzenji" == testModel.cityName)
        XCTAssertTrue(1 == testModel.dayForecasts.count)
    }
    
}
