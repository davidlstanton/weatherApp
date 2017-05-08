//
//  OpenWeatherMapRouter.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation
import Alamofire

enum OpenWeatherMapRouter: URLRequestConvertible {
    
    case forcast7DaysDaily(cityId: Int)

    
    func asURLRequest() throws -> URLRequest {
        return URLRequest(url: URL(string: "http://test.com")!)
    }
    
}
