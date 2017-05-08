//
//  OpenWeatherMapService.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation
import Alamofire

class OpenWeatherMapService: NSObject {
    
    class func weekForecast(cityId: Int, callback: @escaping (ForecastModel?, Error?) -> ()){
        _ = Alamofire.request(OpenWeatherMapRouter.forecast7DaysDaily(cityId: cityId)).validate().responseObject { (response: DataResponse<ForecastModel>) in
            if let error = response.error {
                callback(nil, error)
                return
            }
            if let forecastModel = response.result.value {
                callback(forecastModel, nil)
            }
        }
    }
    
}
