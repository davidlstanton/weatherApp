//
//  DayForecastCacheModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class DayForecastCacheModel: NSObject {

    let cityId: Int
    let cityName: String
    let forecastDate: Date
    let tempDay: Double?
    let tempNight: Double?
    let weatherDescription: String?
    let weatherIcon: String?
    
    init(
        cityId: Int,
        cityName: String,
        forecastDate: Date,
        tempDay: Double?,
        tempNight: Double?,
        weatherDescription: String?,
        weatherIcon: String?) {
        self.cityId = cityId
        self.cityName = cityName
        self.forecastDate = forecastDate
        self.tempDay = tempDay
        self.tempNight = tempNight
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
    }
}
