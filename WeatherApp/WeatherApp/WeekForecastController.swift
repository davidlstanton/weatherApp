//
//  WeekForecastController.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class WeekForecastController: NSObject {
    
    let weatherNetworkService: WeekForcastNetworkService?
    
    init(networkService: WeekForcastNetworkService?) {
        self.weatherNetworkService = networkService
    }
    
    func viewModelForForecast(cityId: Int, callback: @escaping ([DayForecastViewModel]?, ViewError?) -> () ) {
        // hit cache service:
        //    if valid cache return cache.
        //    if invalid cache, show cache then fetch from network
        //    if no cache, fetch from network
        
        forecastWeek(cityId: cityId) { (viewModel, viewError) in
            if let viewError = viewError {
                callback(nil, viewError)
                return
            }
            if let viewModel = viewModel {
                callback(viewModel, nil)
            } else {
                // TODO should be no data error
                callback(nil, ViewError.notImplemented)
            }
        }
    }
    
    internal func forecastWeek(cityId: Int, callback:@escaping ([DayForecastViewModel]?, ViewError?)->() ) {
        weatherNetworkService!.weekForecast(cityId: cityId) { (model, error) in
            if let error = error {
                callback(nil, self.backEndErrorToViewError(error: error))
                return
            }
            if let model = model {
                let viewModel = model.dayForecasts.map {
                return self.dayForecastModelToViewModel(dayForecastModel: $0)}
            callback(viewModel, nil)
            }
        }
    }
    
    internal func backEndErrorToViewError(error: BackendError) -> ViewError {
        return .notImplemented
    }
    
    internal func dayForecastModelToViewModel(dayForecastModel: DayForecastModel) -> DayForecastViewModel {
        let dateStringz = dateStrings(from: dayForecastModel.forecastDate)
        let tempStringz = tempStrings(day: dayForecastModel.tempDay, night: dayForecastModel.tempNight)
        return DayForecastViewModel(
            day: dateStringz.day,
            dateString: dateStringz.dateString,
            dayTemp: tempStringz.day,
            nightTemp: tempStringz.night,
            weatherDescription: dayForecastModel.weatherDescription ?? "Have a great day")
            //TO DO: better no weather description message
    }
    
    internal func tempStrings(day: Double?, night: Double?) -> (day: String, night: String) {
        var dayString = "Day temp unknown"
        var nightString = "Night temp unknown"
        if let day = day {
            dayString = "Day: \(day)℃"
        }
        if let night = night {
            nightString = "Night: \(night)℃"
        }
        return (dayString, nightString)
    }
    
    internal func dateStrings(from: Date) -> (day: String, dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: from)
        dateFormatter.dateFormat = "E"
        let dayString = dateFormatter.string(from: from)
        return (dayString, dateString)
    }
    
}
