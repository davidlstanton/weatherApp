//
//  DayForecastViewModel.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class DayForecastViewModel {
    
    let day: String
    let dateString: String?
    let dayTemp: Double?
    let nightTemp: Double?
    let weatherDescription: String?
    
    init(day: String,
         dateString: String?,
         dayTemp: Double?,
         nightTemp: Double?,
         weatherDescription: String?) {
        
        self.day = day
        self.dateString = dateString
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.weatherDescription = weatherDescription
    }
}
