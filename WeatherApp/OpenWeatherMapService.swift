//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation
import Alamofire

protocol WeekForcastNetworkService {
    func weekForecast(cityId: Int, callback: @escaping (ForecastModel?, BackendError?) -> ())
}

class OpenWeatherMapService: WeekForcastNetworkService {
    
    func weekForecast(cityId: Int, callback: @escaping (ForecastModel?, BackendError?) -> ()){
        _ = Alamofire.request(OpenWeatherMapRouter.forecast7DaysDaily(cityId: cityId)).validate().responseObject { (response: DataResponse<ForecastModel>) in
            if let error = response.error {
                // TODO Check this is always a backend error (I think it is) but needs a check.
                callback(nil, error as? BackendError)
                return
            }
            if let forecastModel = response.result.value {
                callback(forecastModel, nil)
            }
        }
    }
    
}
