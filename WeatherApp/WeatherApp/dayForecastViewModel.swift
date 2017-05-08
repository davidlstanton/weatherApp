//
//  dayForecastViewModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class dayViewModel {
    
    let cityId: Int
    let dayTemp: Double
    let nightTemp: Double
    let weatherDescription: String
    
    init(cityId: Int,
         dayTemp: Double,
         nightTemp: Double,
         weatherDescription: String) {
        
        self.cityId = cityId
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.weatherDescription = weatherDescription
    }
}
