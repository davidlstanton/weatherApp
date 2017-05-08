//
//  WeekForecastControllerTests.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import XCTest
@testable import WeatherApp


class WeekForecastControllerTests: XCTestCase {
    
    var weekForcastController: WeekForecastController?
    
    override func setUp() {
        super.setUp()
        weekForcastController = WeekForecastController(weatherService: nil)
    }
    
    func testDayForecastModelToViewModel() {
        let expected = DayForecastViewModel(day: "Mon", dateString: "8/5/17", dayTemp: 10, nightTemp: 8, weatherDescription: "Cloudy with a chance of meatballs")
        let date = Date(timeIntervalSince1970: 1494260330) // 8/05/2017
        let testData = DayForecastModel(
            forecastDate: date,
            tempDay: 10.0,
            tempNight: 8.0,
            weatherDescription: "Cloudy with a chance of meatballs",
            weatherIcon: "icon")
        let testModel = weekForcastController!.dayForecastModelToViewModel(dayForecastModel: testData)
        XCTAssertTrue(testModel.dateString == expected.dateString)
        XCTAssertTrue(testModel.day == expected.day)
        XCTAssertTrue(testModel.dayTemp == expected.dayTemp)
        XCTAssertTrue(testModel.nightTemp == expected.nightTemp)
        XCTAssertTrue(testModel.weatherDescription == expected.weatherDescription)
    }
    
}
