//
//  OpenWeatherMapCache.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit
import CoreData

protocol WeekForecastCacheService {
    func add(cacheModel: DayForecastCacheModel)
    func get(cityId: Int, callback: @escaping ([DayForecastCacheModel]?) -> () )
}

class OpenWeatherMapCache: WeekForecastCacheService {
    
    var errorHandler: (Error) -> Void = {_ in }
    let name: String
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.name)
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                print("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    
    
    func add(cacheModel: DayForecastCacheModel) {
        performBackgroundTask { (moc) in
            let dayForecastEntity = NSEntityDescription.insertNewObject(forEntityName: "DayForecastEntity", into: moc) as! DayForecastEntity
            dayForecastEntity.cityId = Int64(cacheModel.cityId)
            dayForecastEntity.cityName = cacheModel.cityName
            dayForecastEntity.forecastDate = cacheModel.forecastDate as NSDate
            if let tempDay = cacheModel.tempDay {
            dayForecastEntity.tempDay = tempDay
            }
            if let tempNight = cacheModel.tempNight {
                dayForecastEntity.tempNight = tempNight
            }
            dayForecastEntity.weatherDescription = cacheModel.weatherDescription
            dayForecastEntity.weatherIcon = cacheModel.weatherIcon
            try? moc.save()
        }
    }
    
    
    func get(cityId: Int, callback: @escaping ([DayForecastCacheModel]?) -> () ) {
        performForegroundTask { (moc) in
            let forecastFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DayForecastEntity")
            forecastFetch.predicate = NSPredicate(format: "date > %@ AND cityId == %@", argumentArray:[Date() as NSDate, String(cityId)])
            do {
                let fetchedForecasts = try moc.fetch(forecastFetch) as! [DayForecastEntity]
                let cacheModelArray = fetchedForecasts.map { return self.managedModelToModel(managedModel: $0) }
                callback(cacheModelArray)
            } catch {
                callback(nil)
            }
        }
    }
    
    func managedModelToModel(managedModel: DayForecastEntity) -> DayForecastCacheModel {
        let cacheModel = DayForecastCacheModel(
            cityId: Int(managedModel.cityId),
            cityName: managedModel.cityName!,
            forecastDate: managedModel.forecastDate! as Date,
            tempDay: managedModel.tempDay,
            tempNight: managedModel.tempNight,
            weatherDescription: managedModel.weatherDescription,
            weatherIcon: managedModel.weatherIcon)
        return cacheModel
    }
    
    init(name: String) {
        self.name = name
    }
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    
}
