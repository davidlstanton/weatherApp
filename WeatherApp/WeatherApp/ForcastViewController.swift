//
//  ForcastViewController.swift
//  WeatherApp
//
//  Created by David on 08/05/2017.
//  Copyright © 2017 DavidStanton. All rights reserved.
//

import UIKit

class ForcastViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let pickerDataSource = [["London",2643743], ["Paris",6455259], ["New York",5128638]]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: ForcastTableView!
    let dataProvider = WeekForecastController(networkService: OpenWeatherMapService(), cacheService: OpenWeatherMapCache())

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row] [0] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
            let cityId = pickerDataSource[row][1] as! Int
            dataProvider.viewModelForForecast(cityId: cityId) { (model, error) in
                if let error = error {
                    //TO DO handle error
                    print(error)
                    return
                }
                if let model = model{
                    self.tableView.setData(viewModel: model)
                }
            }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
