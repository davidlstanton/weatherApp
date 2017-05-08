//
//  DayForecastModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//
//  Visit https://openweathermap.org/forecast16 for the full list of properties
//
//  Documentation is unclear about which fields can be optional, thus assuming everything but time might be

import UIKit

final class DayForecastModel: ResponseObjectSerializable, ResponseCollectionSerializable {
    
    let forecastDate: Date
    let tempDay: Double?
    let tempNight: Double?
    let weatherDescription: String?
    let weatherIcon: String?
    
    required init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let forecastTimeEpoch = representation["dt"] as? Int
        else {
                return nil
        }
        forecastDate = Date(timeIntervalSince1970: TimeInterval(forecastTimeEpoch))
        tempDay = (representation["temp"] as? [String:Any])?["day"] as? Double
        tempNight = (representation["temp"] as? [String:Any])?["night"] as? Double
        //TO Do: Break the below up into manageable chunks (the dark side of swift? as? ?)
        weatherDescription = ((representation["weather"] as? [Any])?.first as? [String:Any])?["description"] as? String
        weatherIcon = ((representation["weather"] as? [Any])?.first as? [String:Any])?["icon"] as? String
    }

    init(
        forecastDate: Date,
        tempDay: Double,
        tempNight: Double,
        weatherDescription: String,
        weatherIcon: String) {
        self.forecastDate = forecastDate
        self.tempDay = tempDay
        self.tempNight = tempNight
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
    }
}
