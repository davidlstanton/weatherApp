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
    func add(cacheModels: [DayForecastCacheModel])
    func get(cityId: Int, callback: @escaping ([DayForecastCacheModel]?) -> () )
}

class OpenWeatherMapCache: WeekForecastCacheService {
    
    var errorHandler: (Error) -> Void = {_ in }
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ForecastCache")
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
    
    
    
    func add(cacheModels: [DayForecastCacheModel]) {
        if cacheModels.count > 1 {
            performBackgroundTask { (moc) in
                //delete previous
                
                let forecastFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DayForecastEntity")
                forecastFetch.predicate = NSPredicate(format: "cityId == %@", argumentArray:[cacheModels[0].cityId])
                if let fetchedForecasts = try? moc.fetch(forecastFetch) as! [DayForecastEntity] {
                    for mo in fetchedForecasts {
                        moc.delete(mo)
                    }
                }

                //add new
                for cacheModel in cacheModels {
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
                }
                try? moc.save()
            }
        }
    }
    
    func get(cityId: Int, callback: @escaping ([DayForecastCacheModel]?) -> () ) {
        performForegroundTask { (moc) in
            let forecastFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "DayForecastEntity")
            forecastFetch.predicate = NSPredicate(format: "forecastDate >= %@ AND cityId == %@", argumentArray:[Date(timeIntervalSinceNow: TimeInterval(-60*60)) as NSDate, String(cityId)])
            do {
                let fetchedForecasts = try moc.fetch(forecastFetch) as! [DayForecastEntity]
                let cacheModelArray = fetchedForecasts.map { return self.managedModelToModel(managedModel: $0) }
                callback(cacheModelArray)
            } catch {
                callback(nil)
            }
        }
    }
    
    private func managedModelToModel(managedModel: DayForecastEntity) -> DayForecastCacheModel {
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
    
    private func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    private func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    
}
