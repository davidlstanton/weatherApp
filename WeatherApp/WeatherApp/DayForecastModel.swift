//
//  DayForecastModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

/*
 list
 list.dt Time of data forecasted
 list.temp
 list.temp.day Day temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.temp.min Min daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.temp.max Max daily temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.temp.night Night temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.temp.eve Evening temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.temp.morn Morning temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
 list.pressure Atmospheric pressure on the sea level, hPa
 list.humidity Humidity, %
 list.weather (more info Weather condition codes)
 list.weather.id Weather condition id
 list.weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
 list.weather.description Weather condition within the group
 list.weather.icon Weather icon id
 list.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
 list.deg Wind direction, degrees (meteorological)
 list.clouds Cloudiness, %
 
 
 */

import UIKit

class DayForecastModel: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    let forecastDate: Date
    let tempDay: Double
    let tempNight: Double
    let weatherDescription: String
    let weatherIcon: String
    
    required init?(response: HTTPURLResponse, representation: Any) {
        forecastDate = Date()
        tempDay = 0
        tempNight = 0
        weatherDescription = ""
        weatherIcon = ""
    }
}
