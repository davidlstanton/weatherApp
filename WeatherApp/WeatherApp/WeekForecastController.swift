//
//  WeekForecastController.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class WeekForecastController: NSObject {
    
    let weatherService: WeekForcastNetworkService?
    
    init(weatherService: WeekForcastNetworkService?) {
        self.weatherService = weatherService
    }
    
    func viewModelForForecast(cityId: Int, callback: ([DayForecastModel]?, ViewError?) -> () ) {
        // hit cache service:
        //    if valid cache return cache.
        //    if invalid cache, show cache then fetch from network
        //    if no cache, fetch from network
        
        
    }
    
    func forecastWeek(cityId: Int, callback:([DayForecastModel]?, BackendError?)->() ) {
        weatherService!.weekForecast(cityId: cityId) { (model, error) in
            print("")
        }
    }
    
    func backEndErrorToViewError(error: BackendError) -> ViewError {
        return .notImplemented
    }
    
    func dayForecastModelToViewModel(dayForecastModel: DayForecastModel) -> DayForecastViewModel {
        let dateStringz = dateStrings(from: dayForecastModel.forecastDate)
        return DayForecastViewModel(
            day: dateStringz.day,
            dateString: dateStringz.dateString,
            dayTemp: dayForecastModel.tempDay,
            nightTemp: dayForecastModel.tempNight,
            weatherDescription: dayForecastModel.weatherDescription)
    }
    
    func dateStrings(from: Date) -> (day: String, dateString: String) {
        return ("Mon", "17/01/2017")
    }
    
}
