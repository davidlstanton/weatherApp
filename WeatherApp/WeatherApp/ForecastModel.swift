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
    let dayForecasts: [Any]
    
    required init?(response: HTTPURLResponse, representation: Any) {
        self.cityId = 0
        self.cityName = ""
        self.cityCountryCode = ""
        dayForecasts = []
    }
    
}
