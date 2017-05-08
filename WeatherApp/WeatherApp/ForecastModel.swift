//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation

final class ForecastModel: ResponseObjectSerializable {

    let cityId: Int
    let cityName: String
    let cityCountryCode: String
    let dayForecasts: [DayForecastModel]
    
    required init?(response: HTTPURLResponse, representation: Any) {
        
        guard
            let representation = representation as? [String: Any],
            let cityRepresentation = representation["city"] as? [String: Any],
            let cityId = cityRepresentation["id"] as? Int,
            let cityName = cityRepresentation["name"] as? String,
            let cityCountryCode = cityRepresentation["country"] as? String
        else {
            return nil
        }
        self.cityId = cityId
        self.cityName = cityName
        self.cityCountryCode = cityCountryCode
        self.dayForecasts = DayForecastModel.collection(from: response,
                                                   withRepresentation: representation["list"] ?? [])
    }
    
}
