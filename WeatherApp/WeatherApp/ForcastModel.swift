//
//  ForcastModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation

final class ForcastModel: ResponseObjectSerializable {

    let cityId: Int
    let cityName: String
    let cityCountryCode: String
    let dayForcasts: [Any]
    
    required init?(response: HTTPURLResponse, representation: Any) {
        self.cityId = 0
        self.cityName = ""
        self.cityCountryCode = ""
        dayForcasts = []
    }
    
}
