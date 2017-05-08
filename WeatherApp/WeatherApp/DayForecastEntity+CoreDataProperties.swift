//
//  DayForecastEntity+CoreDataProperties.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import Foundation
import CoreData


extension DayForecastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayForecastEntity> {
        return NSFetchRequest<DayForecastEntity>(entityName: "DayForecastEntity")
    }

    @NSManaged public var cityId: Int64
    @NSManaged public var cityName: String?
    @NSManaged public var forecastDate: NSDate?
    @NSManaged public var tempDay: Double
    @NSManaged public var tempNight: Double
    @NSManaged public var weatherDescription: String?
    @NSManaged public var weatherIcon: String?

}
