//
//  OpenWeatherMapRouter.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//
//  Language and Units could be passed in here, this data would then also decorate the model object
//  Not really needed for an MVP but if this was going further it would make alot of sense.
//
//  Also one can make a debate as to whether the api key should be here, in a plist config file or injected by CI at build time.

import Foundation
import Alamofire

enum OpenWeatherMapRouter: URLRequestConvertible {
    
    static let baseURL = "http://api.openweathermap.org"
    static let apiKey = "429526511ef680c746780f52256f740a"
    
    case forecast7DaysDaily(cityId: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        var result: (path: String, parameters: Parameters) = {
            switch self {
            case let .forecast7DaysDaily(cityId):
                let parameters = ["id":String(cityId)]
                let path = "/data/2.5/forecast/daily"
                return (path, parameters)
            }
        }()
        
        result.parameters["units"] = "metric"
        result.parameters["appid"] = OpenWeatherMapRouter.apiKey
        let url = try OpenWeatherMapRouter.baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
    
}
