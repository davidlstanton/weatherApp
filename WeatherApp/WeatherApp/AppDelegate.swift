//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        OpenWeatherMapService.weekForecast(cityId: 1851632) { (model, error) in
            if let error = error {
                print(error)
                return
            }
            if let model = model {
                print(model.cityName)
            }
        }
        
        return true
    }

}

